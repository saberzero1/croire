local _time = require 'os'

local ZERO = 0

-- A class capturing the platform's idea of local time.

local STDOFFSET = -_time.time() % 86400
local DSTOFFSET = _time.daylight() and -_time.altzone() or STDOFFSET

local DSTDIFF = DSTOFFSET - STDOFFSET

local LocalTimezone = {}
LocalTimezone.__index = LocalTimezone

function LocalTimezone:new()
    return setmetatable({}, self)
end

function LocalTimezone:utcoffset(dt)
    if self:_isdst(dt) then
        return DSTOFFSET
    else
        return STDOFFSET
    end
end

function LocalTimezone:dst(dt)
    if self:_isdst(dt) then
        return DSTDIFF
    else
        return ZERO
    end
end

function LocalTimezone:tzname(dt)
    return _time.tzname[self:_isdst(dt) and 1 or 2]
end

function LocalTimezone:_isdst(dt)
    local tt = os.date("*t", os.time(dt))
    return tt.isdst > 0
end

local LOCAL_TZ = LocalTimezone:new()