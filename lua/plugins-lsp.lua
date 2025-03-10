return
{
  -- LSP and Mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      -- TODO: add mypy (does not lsp directly though)
      require("mason-lspconfig").setup {
        ensure_installed = { "pyright", "ruff", "lua_ls" },
      }
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup {
        capabilities = capabilities,
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              extraPaths = { "." }, -- Treat project root as PYTHONPATH
            },
          },
        },
      }
      lspconfig.ruff.setup {}
      lspconfig.lua_ls.setup {}

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "h", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>ai", require("lspimport").import, { noremap = true })

          -- manual formatting, happens on save with ruff already
          -- vim.keymap.set("n", "<leader>f", function()
          --   vim.lsp.buf.format({ async = true })
          -- end, opts)
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        -- autoformat on save
        group = vim.api.nvim_create_augroup("lsp_autoformat", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format { async = false, bufnr = args.buf, id = client.id }
              end,
            })
          end
        end
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client.name == 'ruff' then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end,
        desc = 'LSP: Disable hover capability from Ruff',
      })
    end,
  },
  { "stevanmilic/nvim-lspimport" }
}
