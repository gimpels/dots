return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {},
    config = function()
      local handlers = require("config.lsp.handlers")
      local config = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities
      }

      local lsps = { "gopls", "zls", "clangd", "html", "cssls",  "gdscript" }
      for _, ls in ipairs(lsps) do
        vim.lsp.config(ls, config)
        vim.lsp.enable(ls)
      end

      vim.lsp.config("lua_ls", {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      vim.lsp.config("helm-ls", {
        settings = {
          ['helm-ls'] = {
            yamlls = {
              path = "yaml-language-server"
            }
          }
        }
      })
      vim.lsp.enable("helm-ls")
    end
  }
}
