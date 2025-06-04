local settings = {}

settings.spec = {
  -- add LazyVim and import its plugins
  { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
  -- vsc*de
  { import = 'lazyvim.plugins.extras.vscode' },
  -- ai
  { import = 'lazyvim.plugins.extras.ai.copilot' },
  -- coding
  { import = 'lazyvim.plugins.extras.coding.luasnip' },
  { import = 'lazyvim.plugins.extras.coding.mini-surround' },
  { import = 'lazyvim.plugins.extras.coding.yanky' },
  -- dap
  { import = 'lazyvim.plugins.extras.dap.core' },
  { import = 'lazyvim.plugins.extras.dap.nlua' },
  -- editor
  { import = 'lazyvim.plugins.extras.editor.fzf' },
  { import = 'lazyvim.plugins.extras.editor.harpoon2' },
  { import = 'lazyvim.plugins.extras.editor.telescope' },
  -- formatting
  { import = 'lazyvim.plugins.extras.linting.eslint' },
  { import = 'lazyvim.plugins.extras.formatting.prettier' },
  -- language
  { import = 'lazyvim.plugins.extras.lang.git' },
  { import = 'lazyvim.plugins.extras.lang.markdown' },
  { import = 'lazyvim.plugins.extras.lang.nix' },
  { import = 'lazyvim.plugins.extras.lang.sql' },
  { import = 'lazyvim.plugins.extras.lang.svelte' },
  { import = 'lazyvim.plugins.extras.lang.toml' },
  { import = 'lazyvim.plugins.extras.lang.typescript' },
  { import = 'lazyvim.plugins.extras.lang.yaml' },
  -- ui
  { import = 'lazyvim.plugins.extras.ui.treesitter-context' },
  -- util
  { import = 'lazyvim.plugins.extras.util.gitui' },
}

settings.ui = {
  -- If you are using a Nerd Font: set icons to an empty table which will use the
  -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
  backdrop = 100,
  icons = vim.g.have_nerd_font and {} or {
    cmd = '⌘',
    config = '🛠',
    event = '📅',
    ft = '📂',
    init = '⚙',
    keys = '🗝',
    plugin = '🔌',
    runtime = '💻',
    require = '🌙',
    source = '📄',
    start = '🚀',
    task = '📌',
    lazy = '💤 ',
  },
}

settings.performance = {
  rtp = {
    -- disable some rtp plugins, add more to your liking
    disabled_plugins = {
      'gzip',
      'netrwPlugin',
      'tarPlugin',
      'tohtml',
      'zipPlugin',
    },
  },
}

settings.checker = {
  enabled = false,
  notify = false,
}

settings.default = {
  lazy = false,
  version = false, -- always use the latest git commit
}

return settings
