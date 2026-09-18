{
  # Filetype registrations.
  #
  # Two jobs here:
  #
  # 1. Silence `:checkhealth vim.lsp` "Unknown filetype" warnings. An LSP server
  #    that advertises a filetype Neovim has never heard of triggers one warning
  #    each. The culprits are both servers we keep:
  #      - tailwindcss-language-server (lsp.nix preset) advertises essentially
  #        every template-engine filetype: aspnetcorerazor, astro-markdown,
  #        django-html, edge, ejs, erb, gohtml, gohtmltmpl, hbs, html-eex, jade,
  #        leaf, njk, nunjucks, postcss, reason, slim, sugarss
  #      - bash-language-server advertises the `ash` and `dash` shell dialects
  #    Registering the names makes them known. (Tailwind is genuinely used here
  #    -- 5 tailwind.config.* files across the repos -- so the preset stays.)
  #
  # 2. Genuine detection Neovim lacks by default (MDX, compose/gitlab YAML).
  #
  # Filetypes for languages that are no longer configured (cue, edn, fsharp,
  # eelixir, menhir, ocamlinterface, ocamllex, terraform-vars, gowork, helm
  # values, ...) were dropped along with their servers.
  #
  # KNOWN REMAINING (pre-existing, also present before this cleanup): 'gohtml'
  # and 'django-html' still warn. Neovim resolves `filename` > `pattern` >
  # `extension`, so the `.*%.gohtml` -> gohtmltmpl pattern shadows the gohtml
  # extension entry, and django-html is only produced by a content-sniffing
  # pattern function. Neither filetype is ever actually reached, so the warning
  # can't be cleared without giving up gohtmltmpl/django-html detection. Purely
  # cosmetic; both are only advertised by tailwindcss-language-server.
  programs.nvf.settings.vim.luaConfigRC.filetype = ''
    vim.filetype.add({
      extension = {
        -- Shell dialects advertised by bash-language-server
        ash = "ash",
        dash = "dash",

        -- Template engines advertised by tailwindcss-language-server
        edge = "edge",
        ejs = "ejs",
        erb = "erb",
        hbs = "hbs",
        jade = "jade",
        pug = "jade",
        leaf = "leaf",
        njk = "njk",
        nunjucks = "nunjucks",
        slim = "slim",
        gohtml = "gohtml",
        cshtml = "aspnetcorerazor",
        re = "reason",
        rei = "reason",
        pcss = "postcss",
        sss = "sugarss",

        -- MDX (markdown superset, not detected by default)
        mdx = "mdx",
      },
      pattern = {
        -- Remaining tailwind filetypes that need pattern matching
        [".*%.gohtml"] = "gohtmltmpl",
        [".*%.eex$"] = "html-eex",
        [".*%.astro%.md$"] = "astro-markdown",
        [".*/templates/.*%.html$"] = function(path, _)
          local lines = vim.fn.readfile(path, "", 50)
          local content = table.concat(lines, "\n")
          if content:match("{%%") or content:match("{{") then
            return "django-html"
          end
          return nil
        end,

        -- YAML variants: give yaml-language-server the right schema
        [".*/docker%-compose[^/]*%.ya?ml$"] = "yaml.docker-compose",
        [".*/compose[^/]*%.ya?ml$"] = "yaml.docker-compose",
        [".*/%.gitlab%-ci%.ya?ml$"] = "yaml.gitlab",
        [".*/%.gitlab/[^/]*%.ya?ml$"] = "yaml.gitlab",

        -- MDX
        [".*%.mdx$"] = "mdx",
        [".*%.markdown%.mdx$"] = "markdown.mdx",
      },
      filename = {
        -- Docker Compose
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["compose.yml"] = "yaml.docker-compose",
        ["compose.yaml"] = "yaml.docker-compose",

        -- GitLab CI
        [".gitlab-ci.yml"] = "yaml.gitlab",
        [".gitlab-ci.yaml"] = "yaml.gitlab",
      },
    })
  '';
}
