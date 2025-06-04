-- From https://gitlab.com/code-stats/code-stats-vim

---@type LazySpec
return {
  'code-stats/code-stats-vim',
  url = 'https://gitlab.com/code-stats/code-stats-vim.git',
  lazy = true,
  enable = false,
  event = "VeryLazy",
  config = function()
    local api_key = vim.api.nvim_exec('! printenv CODESTATS_API_KEY', true)
    if api_key == nil or api_key == '' then
      vim.g.codestats_error = 'No CodeStats API key found'
    else
      vim.g.codestats_api_key = api_key
      vim.g.codestats_api_url = 'https://codestats.net/'
    end
    vim.g.codestats_loaded = true
  end
}