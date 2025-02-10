return {
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {},
    --- @type TSConfig
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "cmake",
        "diff",
        "dockerfile",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "git_rebase",
        "glsl",
        "graphql",
        "http",
        "json",
        "json5",
        "make",
        "meson",
        "nix",
        "proto",
        "scss",
        "sql",
        "vue",
      })
      -- opts.autopairs = { enable = true }
      opts.autotag = { enable = true }
      opts.matchup = {
        enable = true,
        disable = { "c", "cpp" },
        enable_quotes = true,
      }
      opts.playground = {
        enable = true,
        persist_queries = true, -- Whether the query persists across vim sessions
      }
      opts.query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      }
    end,
  },
}
