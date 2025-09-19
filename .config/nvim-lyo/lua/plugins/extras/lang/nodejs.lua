return {
  -- Add JavaScript & friends to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "css", "html", "javascript", "jsdoc", "scss" })
      end
    end,
  },

  -- Ensure CSS LSP, HTML LSP, and JS Debug Adapter are installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "css-lsp", "html-lsp", "js-debug-adapter" })
      end
    end,
  },
}
