return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local action_layout = require("telescope.actions.layout")

      telescope.setup {
        defaults = {
          prompt_prefix = "> ",
          selection_caret = "> ",
          entry_prefix = "  ",
          multi_icon = "<>",
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-?>"] = actions.which_key,
              ["<M-y>"] = action_layout.toggle_preview,
              ["<M-m>"] = action_layout.toggle_mirror,
              ["<M-t>"] = action_layout.cycle_layout_next,
              ["<C-f>"] = actions.send_to_qflist,
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,
            },
            n = {
              ["?"] = actions.which_key,
              ["<C-f>"] = actions.send_to_qflist,
            },
          },
          file_ignore_patterns = {
            "%.uid",
            "server.pipe",
          }
        },
        pickers = {
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
              i = {
                ["<C-e>"] = actions.delete_buffer
              },
              n = {
                ["d"] = actions.delete_buffer
              }
            }
          },
          live_grep = {
            additional_args = function(_)
              return { "--hidden" }
            end
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
          },
          file_browser = {
            theme = "dropdown",
            path = "%:p:h",
            previewer = false,
            grouped = true,
            hijack_netrw = true,
            layout_config = { height = 0.4 },
            hidden = { file_browser = true, folder_browser = true },
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
              },
              ["n"] = {
                -- your custom normal mode mappings
              },
            },
          },
        },
      }

      telescope.load_extension("ui-select")
      telescope.load_extension("file_browser")
    end
  },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" }
}
