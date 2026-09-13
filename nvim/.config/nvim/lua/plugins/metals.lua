return {
  {
    "scalameta/nvim-metals",
    config = function()
      local metals = require("metals")
      local metals_config = metals.bare_config()
      local handlers = require("config.lsp.handlers")

      metals_config.settings = {
        startMcpServer = true,
        showImplicitArguments = false,
        showImplicitConversionsAndClasses = false,
        showInferredType = false,
        excludedPackages = {},
        testUserInterface = "Test Explorer"
      }
      metals_config.init_options.statusBarProvider = "on"

      metals_config.on_attach = function(client, bufnr)
        metals.setup_dap()
        handlers.on_attach(client, bufnr)
      end

      metals_config.capabilities = handlers.capabilities


      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt" },
        callback = function()
          metals.initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group
      })
    end
  },
}
