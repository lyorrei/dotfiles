local exclude = {
  -- VCS
  ".git",
  -- Deps
  "node_modules",
  ".venv",
  -- Build output
  "dist",
  "build",
  "out",
  "target",
  ".next",
  ".nuxt",
  -- Caches
  ".cache",
  "__pycache__",
  ".pytest_cache",
  ".mypy_cache",
  ".ruff_cache",
  ".turbo",
  -- Tests
  "coverage",
  -- IDE
  ".idea",
  -- Terraform
  ".terraform",
  "terraform.tfstate",
  "terraform.tfstate.backup",
  "*.tfplan",
}

local picker_defaults = { hidden = true, ignored = true, exclude = exclude }

return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = picker_defaults,
        smart = picker_defaults,
        grep = picker_defaults,
        explorer = picker_defaults,
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
