{
  # Add filetype associations for LSP servers that use non-standard filetypes
  # These resolve the "Unknown filetype" warnings from :checkhealth vim.lsp
  #
  # The warnings indicate that LSP servers are configured to handle filetypes
  # that Neovim doesn't recognize by default. We register these filetypes
  # so that:
  # 1. Files with certain extensions get the correct filetype
  # 2. The filetype names themselves are valid in Neovim
  programs.nvf.settings.vim.luaConfigRC.filetype = ''
    vim.filetype.add({
      extension = {
        -- Clojure EDN files - register as 'edn' filetype (not 'clojure')
        edn = "edn",

        -- CUE language
        cue = "cue",

        -- Elixir templates
        eex = "eelixir",
        leex = "eelixir",

        -- F#
        fs = "fsharp",
        fsi = "fsharp",
        fsx = "fsharp",
        fsscript = "fsharp",

        -- Go
        tmpl = "gotmpl",

        -- OCaml family
        mly = "menhir",
        mli = "ocamlinterface",
        mll = "ocamllex",
        re = "reason",
        rei = "reason",

        -- HTML variants
        shtml = "shtml",
        htm = "htm",

        -- WebGPU Shading Language
        wgsl = "wgsl",

        -- Terraform
        tfvars = "terraform-vars",

        -- MDX
        mdx = "mdx",

        -- Template engines and frontend frameworks
        astro = "astro",
        blade = "blade",
        edge = "edge",
        ejs = "ejs",
        erb = "erb",
        hbs = "hbs",
        handlebars = "handlebars",
        jade = "jade",
        pug = "jade",
        leaf = "leaf",
        mustache = "mustache",
        njk = "njk",
        nunjucks = "nunjucks",
        razor = "razor",
        cshtml = "aspnetcorerazor",
        slim = "slim",
        pcss = "postcss",
        sss = "sugarss",
        templ = "templ",

        -- Twig
        twig = "twig",

        -- Go HTML templates
        gohtml = "gohtml",
      },
      pattern = {
        -- Go work files
        ["go%.work"] = "gowork",
        ["go%.work%.sum"] = "gowork",

        -- Go templates
        [".*%.go%.tmpl"] = "gotmpl",
        [".*%.gotmpl"] = "gotmpl",
        [".*%.gohtml"] = "gohtmltmpl",

        -- YAML variants
        [".*/docker%-compose[^/]*%.ya?ml$"] = "yaml.docker-compose",
        [".*/compose[^/]*%.ya?ml$"] = "yaml.docker-compose",
        [".*/%.gitlab%-ci%.ya?ml$"] = "yaml.gitlab",
        [".*/%.gitlab/[^/]*%.ya?ml$"] = "yaml.gitlab",

        -- Helm values files
        [".*/values[^/]*%.ya?ml$"] = function(path, bufnr)
          local dir = vim.fn.fnamemodify(path, ":h")
          if vim.fn.filereadable(dir .. "/Chart.yaml") == 1 or
             vim.fn.filereadable(dir .. "/../Chart.yaml") == 1 then
            return "yaml.helm-values"
          end
          return nil
        end,

        -- MDX files
        [".*%.mdx$"] = "mdx",
        [".*%.markdown%.mdx$"] = "markdown.mdx",

        -- Django templates
        [".*/templates/.*%.html$"] = function(path, bufnr)
          local lines = vim.fn.readfile(path, "", 50)
          local content = table.concat(lines, "\n")
          if content:match("{%%") or content:match("{{") then
            return "django-html"
          end
          return nil
        end,

        -- Elixir templates in Phoenix projects
        [".*%.html%.eex$"] = "eelixir",
        [".*%.html%.leex$"] = "eelixir",
        [".*%.html%.heex$"] = "heex",

        -- HTML EEx
        [".*%.eex$"] = "html-eex",

        -- ASP.NET Razor
        [".*%.cshtml$"] = "aspnetcorerazor",
        [".*%.razor$"] = "razor",

        -- Astro markdown
        [".*%.astro%.md$"] = "astro-markdown",

        -- Blade templates
        [".*%.blade%.php$"] = "blade",
      },
      filename = {
        -- Go
        ["go.work"] = "gowork",
        ["go.work.sum"] = "gowork",

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
