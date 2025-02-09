return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "mrbjarksen/neo-tree-diagnostics.nvim",
      {
        "s1n7ax/nvim-window-picker",
        opts = {
          use_winbar = "smart",
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            bo = {
              filetype = { "neo-tree-popup", "quickfix" },
              buftype = { "terminal", "quickfix", "nofile" },
            },
          },
        },
      },
    },
    opts = function(_, opts)
      opts.filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          visible = true,
          hide_by_name = {
            ".git",
            ".DS_Store",
            ".next",
          },
        },
      }
      opts.close_if_last_window = true -- Close Neo-tree if it is the last window left in the tab
      opts.group_empty_dirs = true -- When true, empty folders will be grouped together
      opts.hijack_netrw_behavior = "open_default" -- netrw disabled, opening a directory opens neo-tree

      opts.window = vim.tbl_deep_extend("force", opts.window or {}, {
        width = 30, -- Adjust this to your preferred start size
      })
    end,
  },

  {
    "flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = function(motion)
            -- never show jump labels by default
            -- return false
            -- Always show jump labels for ftFT
            return vim.v.count == 0 and motion:find("[ftFT]")
            -- Show jump labels for ftFT in operator-pending mode
            -- return vim.v.count == 0 and motion:find("[ftFT]") and vim.fn.mode(true):find("o")
          end,
        },
      },
    },
  },
}
