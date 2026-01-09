-- Extend LazyVim's LSP setup with additional language servers.
-- Mason will auto-install anything listed in opts.servers.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- TypeScript / JavaScript
        ts_ls = {
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          init_options = {
            preferences = {
              disableSuggestions = false,
              includeCompletionsForModuleExports = true,
            },
          },
        },

        -- Python
        pyright = {},

        -- Rust
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              diagnostics = { refreshSupport = false },
            },
          },
        },

        -- Tailwind CSS
        tailwindcss = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css" },
        },

        -- Web: HTML / JSON / CSS
        html = { filetypes = { "html", "twig", "hbs" } },
        jsonls = {},
        cssls = {},

        -- ESLint (runs as LSP, applies fixes on save)
        eslint = {
          settings = {
            codeActionOnSave = { enable = true, mode = "all" },
            experimental = { useFlatConfig = true },
            workingDirectory = { mode = "location" },
          },
        },

        -- C / C++
        clangd = {
          cmd = { "clangd", "--offset-encoding=utf-16" },
        },

        -- Bash / Zsh
        bashls = {
          filetypes = { "sh", "zsh", "bash" },
        },

        -- YAML (docker-compose, CI configs, etc.)
        yamlls = {},

        -- Dockerfile
        dockerls = {},

        -- CSS Modules (Next.js .module.css files)
        cssmodules_ls = {
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },

        -- PostCSS / CSS linting (complements eslint for stylesheets)
        stylelint_lsp = {
          filetypes = { "css", "scss", "less", "sass", "postcss" },
        },
      },
    },
  },
}
