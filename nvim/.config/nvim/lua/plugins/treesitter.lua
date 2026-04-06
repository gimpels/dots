return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    init = function()
      local treesitte = require('nvim-treesitter')

      treesitte.install { 'rust', 'go', 'zig', 'yaml', 'javascript' }

      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          -- Enable treesitter highlighting
          pcall(vim.treesitter.start)

          -- Enable treesitter-based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

          -- Enable treesitter-based folding
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.wo[0][0].foldmethod = 'expr'
        end,
      })
    end,
    opts = {
      sync_install = false,
      auto_install = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0,           -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 2, -- Maximum number of lines to show for a single context
      trim_scope = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',         -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20,     -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    }
  }
}
