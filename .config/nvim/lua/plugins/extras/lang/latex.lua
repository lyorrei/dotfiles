return {

  -- Extend auto completion
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "kdheepak/cmp-latex-symbols",
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  -- local cmp = require("cmp")
  -- opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
  --   { name = "latex_symbols", priority = 700 },
  -- }))
  --   end,
  -- },

  -- Add Latex to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
      end
    end,
  },
}
