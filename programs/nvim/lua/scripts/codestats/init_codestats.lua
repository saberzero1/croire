local CodeStats = require 'scripts.codestats.plugin.codestats'

M = {}

M.codestats = nil

M.init_codestats = function(base_url, api_key)
    --- Plugin startup/reload.
    -- This function unloads previously running version (if any) and initializes
    -- the `codestats` global to a running CodeStats instance.

    base_url = base_url or 'https://codestats.net'
    api_key = api_key or vim.api.nvim_exec('! printenv CODESTATS_API_KEY', true)

    local xp_dict = {}
    -- allow reentrancy
    if _G.codestats then
        xp_dict = codestats.xp_dict
        codestats = nil
    end

    codestats = CodeStats(xp_dict, base_url, api_key)
end

return M
