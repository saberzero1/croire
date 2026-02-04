{ lib, ... }:
let
  lua = map lib.mkLuaInline;
in
{
  programs.nvf.settings.vim.lazy.plugins."lualine-nvim" = {
    enabled = true;
    lazy = true;
    package = "lualine-nvim";
    event = "DeferredUIEnter";
    setupModule = "lualine";
    setupOpts = {
      options = {
        globalstatus = true;
        icons_enabled = true;
        theme = "auto";
      };
      sections = {
        lualine_a = lua [
          ''
            {
              "mode",
              icons_enabled = true,
              separator = {
                left = "",
                right = " "
              }
            }
          ''
          ''
            {
              "",
              draw_empty = true,
              separator = {
                -- left = " ",
                left = "",
                right = " "
              }
            }
          ''
        ];
        lualine_b = lua [
          ''
            {
              "filetype",
              colored = true,
              icon_only = true,
              icon = {
                align = "left"
              },
              separator = {
                left = "",
                right = ""
              }
            }
          ''
          ''
            {
              "filename",
              symbols = {
                modified = " ",
                readonly = " "
              },
              separator = {
                left = "",
                right = " "
              }

            }
          ''
          ''
            {
              "",
              draw_empty = true,
              separator = {
                left = " ",
                right = " "
              }

            }
          ''
        ];
        lualine_c = lua [
          ''
            {
              "diff",
              colored = false,
              diff_color = {
                added = {
                  fg = "DiffAdd"
                },
                modified = {
                  fg = "DiffChange"
                },
                removed = {
                  fg = "DiffDelete"
                }
              },
              symbols = {
                added = "+",
                modified = "~",
                removed = "-"
              },
              separator = {
                right = " "
              }
            }
          ''
        ];
        lualine_x = lua [
          ''
            {
              "",
              draw_empty = true,
              separator = {
                left = " ",
                right = " "
              }
            }
          ''
          ''
            {
              -- Lsp server name
              function()
                local buf_ft = vim.bo.filetype
                local excluded_buf_ft = {
                  toggleterm = true,
                  NvimTree = true,
                  ["neo-tree"] = true,
                  TelescopePrompt = true
                }

                if excluded_buf_ft[buf_ft] then
                  return ""
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr })

                if vim.tbl_isempty(clients) then
                  return "No Active LSP"
                end

                local active_clients = {}
                for _, client in ipairs(clients) do
                  table.insert(active_clients, client.name)
                end

                return table.concat(active_clients, ", ")
              end,
              icon = " ",
              separator = {
                left = " "
              }
            }
          ''
          ''
            {
              "diagnostics",
              sources = {
                "nvim_lsp",
                "nvim_diagnostic",
                "nvim_diagnostic",
                "vim_lsp",
                "coc"
              },
              symbols = {
                error = "󰅙 ",
                warn = " ",
                info = " ",
                hint = "󰌵 "
              },
              colored = true,
              update_in_insert = false,
              always_visible = false,
              diagnostics_color = {
                color_error = {
                  fg = "red"
                },
                color_warn = {
                  fg = "yellow"
                },
                color_info = {
                  fg = "cyan"
                }
              },
              separator = {
                left = " "
              }
            }
          ''
        ];
        lualine_y = lua [
          ''
            {
              "",
              draw_empty = true,
              separator = {
                left = " ",
                right = " "
              }

            }
          ''
          ''
            {
              "searchcount",
              maxcount = 999,
              timeout = 120,
              separator = {
                left = " ",
                right = " "
              }
            }
          ''
          ''
            {
              "branch",
              icon = " •",
              separator = {
                left = " ",
                right = " "
              }

            }
          ''
        ];
        lualine_z = lua [
          ''
            {
              "",
              draw_empty = true,
              separator = {
                left = " ",
                right = ""
              }
            }
          ''
          ''
            {
              "progress",
              separator = {
                left = " ",
                right = ""
              }
            }
          ''
          ''
            {
              "location",
              separator = {
                left = " ",
                right = ""
              }
            }
          ''
          ''
            {
              "fileformat",
              separator = {
                left = " ",
                right = ""
              },
              color = {
                fg = "black"
              },
              symbols = {
                unix = "", -- e712
                dos = "",  -- e70f
                mac = ""   -- e711
              }
            }
          ''
        ];
      };
    };
  };
}
