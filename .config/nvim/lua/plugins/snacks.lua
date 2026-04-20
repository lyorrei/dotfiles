return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = { hidden = true },
        grep = { hidden = true },
        explorer = { hidden = true },
      },
    },
  },
  keys = {
    {
      "<leader>fe",
      function()
        Snacks.explorer({ cwd = vim.fn.getcwd(-1, -1) })
      end,
      desc = "Explorer Snacks (project root)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer Snacks (git root)", remap = true },
  },
}
