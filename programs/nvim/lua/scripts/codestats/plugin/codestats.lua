local json = require 'scripts.codestats.plugin.dependencies.json'
local socket = require 'socket'
local ltn12 = require 'ltn12'
local url = require 'socket.url'

local INTERVAL = 10                -- interval at which stats are sent
local SLEEP_INTERVAL = 0.1         -- sleep interval for timeslicing
local VERSION = '1.2.0'            -- versioning
local TIMEOUT = 2                  -- request timeout value (in seconds)

local CodeStats = {}
CodeStats.__index = CodeStats

function CodeStats:new(xp_dict, base_url, api_key)
    local self = setmetatable({}, CodeStats)
    self.xp_dict = xp_dict
    self.pulse_url = url.absolute("api/my/pulses", base_url)
    self.api_key = api_key
    self.sem = love.thread.newSemaphore()

    -- start the main thread
    self.cs_thread = love.thread.newThread(function() self:main_thread() end)
    self.cs_thread:start()

    return self
end

function CodeStats:add_xp(filetype, xp)
    if xp == 0 then
        return
    end

    -- get the language type based on what vim passed to us
    local language_type = filetype_map[filetype] or filetype

    -- insert the filetype into the dictionary. Sem sections
    -- are super small so this should be quick if it blocks
    self.sem:acquire()
    local count = self.xp_dict[language_type] or 0
    self.xp_dict[language_type] = count + xp
    self.sem:release()
end

function CodeStats:send_xp(exiting)
    if next(self.xp_dict) == nil then
        return
    end

    -- acquire the lock to get the list of xp to send
    self.sem:acquire()
    local xp_list = {}
    for ft, xp in pairs(self.xp_dict) do
        table.insert(xp_list, {language = ft, xp = xp})
    end
    self.xp_dict = {}
    self.sem:release()

    local headers = {
        ["Content-Type"] = "application/json",
        ["User-Agent"] = "code-stats-vim/" .. VERSION,
        ["X-API-Token"] = self.api_key,
        ["Accept"] = "*/*"
    }

    -- after lock is released we can send the payload
    local utc_now = os.date("!%Y-%m-%dT%H:%M:%S", os.time())
    local pulse_json = json.encode({
        coded_at = utc_now,
        xps = xp_list
    })

    local req = {
        url = self.pulse_url,
        method = "POST",
        headers = headers,
        source = ltn12.source.string(pulse_json),
        sink = ltn12.sink.table({})
    }

    local response_body = {}
    local res, code, response_headers, status = http.request(req)

    local error = ''
    if code ~= 200 then
        error = tostring(code) .. " " .. (response_body[1] or "")
    end

    -- hacky way to get around exiting and not needing to set the error
    if not exiting and error ~= '' then
        vim.cmd('call codestats#set_error("' .. error:gsub('"', '\\"') .. '")')
    end
end

function CodeStats:main_thread()
    while true do
        local cur_time = 0
        while cur_time < INTERVAL do
            socket.sleep(SLEEP_INTERVAL)
            cur_time = cur_time + SLEEP_INTERVAL
        end

        self:send_xp()
    end
end

function CodeStats:exit()
    self:send_xp(true)
end

