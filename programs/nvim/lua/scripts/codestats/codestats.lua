-- Lua side file to integrate support for codestats.net

local api_url = vim.g.codestats_api_url or 'https://codestats.net/'
local api_key = vim.g.codestats_api_key or ''
local python_command = vim.fn.has('python3') == 1 and 'py3file' or 'pyfile'
local codestats_path = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand('<sfile>:p')), ':h')

M = {}

M.codestats_xp = function()
    if vim.g.codestats_error then
        return 'C::S ERR'
    end

    if vim.b.current_xp == nil then
        vim.b.current_xp = 0
    end

    return 'C::S ' .. vim.b.current_xp
end

M.flush_xp = function()
    if vim.b.current_xp then
        --local cmd = string.format("%s codestats.add_xp('%s', %d)", python_command, vim.bo.filetype, vim.b.current_xp)
        --vim.cmd(cmd)
        M.add_xp(vim.bo.filetype, vim.b.current_xp)
    end
    vim.b.current_xp = 0
end

M.add_xp = function()
    if vim.b.current_xp == nil then
        vim.b.current_xp = 0
    end
    vim.b.current_xp = vim.b.current_xp + 1
end

M.exit = function()
    M.flush_xp()
    --vim.cmd(string.format("%s codestats.exit()", python_command))
end

M.set_error = function(error)
    if error == '' then
        vim.g.codestats_error = nil
    else
        vim.g.codestats_error = error
    end
end

M.force_send_xp = function()
    M.flush_xp()
    M.send_xp()
end

-- Setup autocommands for tracking code stats
vim.api.nvim_create_augroup('codestats', {})

vim.api.nvim_create_autocmd({'InsertCharPre', 'TextChanged'}, {
    group = 'codestats',
    callback = function()
        M.add_xp()
    end
})

vim.api.nvim_create_autocmd('VimLeavePre', {
    group = 'codestats',
    callback = function()
        M.exit()
    end
})

vim.api.nvim_create_autocmd({'BufWrite', 'BufLeave'}, {
    group = 'codestats',
    callback = function ()
        M.flush_xp()
    end
})


--init_codestats(api_url, api_key)