return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/lazydev.nvim",
  },
  config = function()
    ---------------------------------------------------------------------------
    -- QoL: nicer diagnostics (global, safe)
    ---------------------------------------------------------------------------
    vim.diagnostic.config({
      severity_sort = true,
      underline = { severity = vim.diagnostic.severity.ERROR },
      virtual_text = {
        spacing = 2,
        source = "if_many",
        prefix = "●",
      },
      float = {
        border = "rounded",
        source = "if_many",
      },
    })

    ---------------------------------------------------------------------------
    -- Servers
    ---------------------------------------------------------------------------
    local servers = {
      ltex = { ltex = { enabled = { "tex" }, language = "de-DE" } },

      tailwindcss = {
        filetypes = { "html", "typescriptreact", "javascriptreact", "css" },
      },

      html = { filetypes = { "html", "twig", "hbs" } },
      jsonls = { filetypes = { "json", "jsonc" } },

      ts_ls = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
        init_options = {
          preferences = {
            disableSuggestions = true,
            includeCompletionsForModuleExports = false,
          },
        },
      },

      pyright = { filetypes = { "python" } },

      lua_ls = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim", "require" } },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = { enable = false },
        },
      },

      eslint = {
        codeAction = {
          disableRuleComment = { enable = true, location = "separateLine" },
          showDocumentation = { enable = true },
        },
        codeActionOnSave = { enable = true, mode = "all" },
        experimental = { useFlatConfig = true },
        format = true,
        workingDirectory = { mode = "location" },
      },

      rust_analyzer = { diagnostics = { refreshSupport = false } },
      gopls = {},

      stylelint_lsp = {
        filetypes = { "css", "scss", "less", "sass", "html" },
      },

      cssmodules_ls = {
        filetypes = { "css", "scss", "less", "sass", "html" },
      },

      cssls = {
        filetypes = { "css", "scss", "less", "sass", "html" },
      },

      clangd = {
        offsetEncoding = { "utf-8", "utf-16" },
        textDocument = { completion = { editsNearCursor = true } },
      },
    }

    ---------------------------------------------------------------------------
    -- lazydev
    ---------------------------------------------------------------------------
    require("lazydev").setup({
      library = { "nvim-dap-ui" },
      enabled = true,
      integrations = { cmp = true },
      runtime = vim.env.VIMRUNTIME,
    })

    ---------------------------------------------------------------------------
    -- Yank highlight
    ---------------------------------------------------------------------------
    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = function()
        vim.highlight.on_yank()
      end,
      group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    })

    ---------------------------------------------------------------------------
    -- QoL LspAttach document highlights + inlay hints toggle
    ---------------------------------------------------------------------------
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspQoL", { clear = true }),
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        local function supports(method)
          if client.supports_method then
            return client.supports_method(method)
          end
          local caps = client.server_capabilities or {}
          if method == "textDocument/documentHighlight" then
            return caps.documentHighlightProvider
          end
          if method == "textDocument/inlayHint" then
            return caps.inlayHintProvider
          end
          return false
        end

        -- document highlights
        if supports("textDocument/documentHighlight") then
          local group = vim.api.nvim_create_augroup("UserLspDocumentHighlight:" .. bufnr, { clear = true })

          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.clear_references()
              pcall(vim.api.nvim_del_augroup_by_name, "UserLspDocumentHighlight:" .. bufnr)
            end,
          })
        end

        -- inlay hints toggle
        if supports("textDocument/inlayHint") and vim.lsp.inlay_hint then
          vim.keymap.set("n", "<leader>th", function()
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
            vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
          end, { buffer = bufnr, desc = "Toggle inlay hints" })
        end
      end,
    })

    ---------------------------------------------------------------------------
    -- Mason + LSP setup
    ---------------------------------------------------------------------------
    require("mason").setup()

    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
      handlers = {
        function(server_name)
          -- Don't start vtsls (we use ts_ls)
          if server_name == "vtsls" then
            return
          end
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            flags = { debounce_text_changes = 1000 },
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
            on_attach = function(_, bufnr)
              local nmap = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
              end

              nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
              nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

              local ok, tb = pcall(require, "telescope.builtin")
              if ok then
                nmap("gd", tb.lsp_definitions, "Goto Definition")
                nmap("gr", tb.lsp_references, "Goto References")
                nmap("gI", tb.lsp_implementations, "Goto Implementation")
                nmap("<leader>D", tb.lsp_type_definitions, "Type Definition")
                nmap("<leader>ds", tb.lsp_document_symbols, "Document Symbols")
                nmap("<leader>ws", tb.lsp_dynamic_workspace_symbols, "Workspace Symbols")
              end

              nmap("K", vim.lsp.buf.hover, "Hover")
              nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
            end,
          })
        end,
      },
    })
  end,
}
