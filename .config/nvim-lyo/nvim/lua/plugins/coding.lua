return {
  -- {
  --   "zbirenbaum/copilot.lua",
  --   opts = {
  --     filetypes = { ["*"] = true },
  --     suggestion = { enabled = true, auto_trigger = true },
  --   },
  -- },

  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 200 },
  },
}
