return {
  {
    "oskarnurm/koda.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("koda").setup({
        styles = {
          functions = { bold = false }
        }
      })
      vim.cmd("colorscheme koda-glade")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
  },

}
