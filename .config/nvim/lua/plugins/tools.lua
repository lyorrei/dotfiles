return {
  { "pwntester/octo.nvim", cmd = "Octo", opts = {} },

  -- -- better diffing
  -- {
  --   "sindrets/diffview.nvim",
  --   cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  --   opts = {},
  --   keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  -- },

  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = function()
      require("numb").setup()
    end,
  },

  {
    "psliwka/vim-dirtytalk",
    build = ":DirtytalkUpdate",
    config = function()
      vim.opt.spelllang:append("programming")
    end,
  },

  "wellle/targets.vim",

  { "rafcamlet/nvim-luapad", cmd = "Luapad" },

  {
    "bennypowers/nvim-regexplainer",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter", "MunifTanjim/nui.nvim" },
    config = true,
    opts = {
      mappings = {
        toggle = "ge",
      },
    },
  },

  {
    "~p00f/godbolt.nvim",
    url = "https://git.sr.ht/~p00f/godbolt.nvim",
    cmd = { "Godbolt", "GodboltCompiler" },
  },

  {
    "t-troebst/perfanno.nvim",
    opts = function()
      local util = require("perfanno.util")
      local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
      local bg = string.format("#%06x", hl.bg)
      local fg = "#dc2626"
      return {
        line_highlights = util.make_bg_highlights(bg, fg, 10),
        vt_highlight = util.make_fg_highlight(fg),
      }
    end,
    keys = {
      { "<leader>alf", "<cmd>PerfLoadFlat<cr>", desc = "Load flat profile" },
      { "<leader>alg", "<cmd>PerfLoadCallGraph<cr>", desc = "Load call graph" },
      { "<leader>alo", "<cmd>PerfLoadFlameGraph<cr>", desc = "Load flame graph" },
      { "<leader>ae", "<cmd>PerfPickEvent<cr>", desc = "Pick event" },
      { "<leader>aa", "<cmd>PerfAnnotate<cr>", desc = "Annotate" },
      { "<leader>af", "<cmd>PerfAnnotateFunction<cr>", desc = "Annotate function" },
      { "<leader>at", "<cmd>PerfToggleAnnotations<cr>", desc = "Toggle annotations" },
      { "<leader>ah", "<cmd>PerfHottestLines<cr>", desc = "Hottest lines" },
      { "<leader>as", "<cmd>PerfHottestSymbols<cr>", desc = "Hottest symbols" },
      { "<leader>ac", "<cmd>PerfHottestCallersFunction<cr>", desc = "Hottest callers function" },
      { "<leader>all", "<cmd>PerfLuaProfileStart<cr>", desc = "Start Lua Profiler" },
      { "<leader>als", "<cmd>PerfLuaProfileStop<cr>", desc = "Stop Lua Profiler" },
    },
    cmd = {
      "PerfLuaProfileStart",
      "PerfLuaProfileStop",
      "PerfLoadFlat",
      "PerfLoadCallGraph",
      "PerfLoadFlameGraph",
      "PerfCacheLoad",
      "PerfCacheSave",
      "PerfCacheDelete",
      "PerfCycleFormat",
    },
  },

  {
    "andweeb/presence.nvim",
    event = "BufRead",
    opts = {
      main_image = "file",
      enable_line_number = true,
      blacklist = {
        ".*zsh.*",
        ".*ToggleTerm.*",
        ".*toggleterm.*",
      },
      buttons = false,
      ---@param filename string
      editing_text = function(filename)
        -- if in .config/nvim, return "Editing dotfiles"
        -- if in ~/projects/treesitter/*/grammar.js, return "Editing a tree-sitter grammar"
        -- else return "Editing %s"
        if filename:match(".config/nvim") then
          return "Editing my dotfiles"
        elseif filename:match("projects/treesitter/.+/grammar.js") then
          -- try and get the name from the * part, if it's tree-sitter-{name}, else just return "Editing a tree-sitter grammar"
          local name = filename:match("projects/treesitter/.+/grammar.js"):match("tree%-sitter%-(.+)")
          if name then
            return string.format("Editing %s's tree-sitter grammar", name)
          end
          return "Editing a tree-sitter grammar"
        else
          return string.format("Editing %s", filename)
        end
      end,
      reading_text = function(buf_name) --- @param buf_name string
        local toggleterm_process = buf_name:match("([^;]+);#toggleterm#%d+")

        -- Terminal check
        if toggleterm_process == "lazygit" then
          return "Messing with git"
        elseif toggleterm_process == "zsh" then
          return "In the terminal"
        end

        local lazygit_process = buf_name:match("%d+:(.+)")
        if lazygit_process == "lazygit" then
          return "In Lazygit"
        end

        return string.format("Reading %s", buf_name)
      end,
    },
  },

  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    event = "VeryLazy",
    keys = {
      { "<leader>cs", "<Esc><cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
      { "<leader>cS", "<Esc><cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures/" },
    },
    lazy = true,
    opts = {
      mac_window_bar = false,
      save_path = "~/Pictures/",
      has_breadcrumbs = true,
      show_workspace = true,
      bg_theme = "sea",
      watermark = "",
      code_font_family = "Berkeley Mono",
      has_line_number = true,
    },
  },
}
