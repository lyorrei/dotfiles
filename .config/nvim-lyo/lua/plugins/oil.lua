return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Oil",
  keys = {
    {
      "<leader>o",
      function()
        require("oil").open()
      end,
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
}
