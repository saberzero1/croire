---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  enabled = true,
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      -- pyright will be automatically installed with mason and loaded with lspconfig
      pyright = {},

      ts_ls = {},

      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },

      nixd = {
        formatting = {
          command = { 'nixfmt' },
        },
      },

      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = true,
          },
        },
      },

      yamlls = {
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      },
    },
  },
}
