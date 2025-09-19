return {
  -- Disable default <Tab> and <S-Tab> behaviors in LuaSnip to control it explicitly in nvim-cmp
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {} -- Return an empty keymap for LuaSnip
    end,
  },

  -- Set up nvim-cmp for handling completions, including the behavior of the <Tab> and <S-Tab> keys
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji", -- Add emoji support to the completions
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require("copilot_cmp")
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          LazyVim.lsp.on_attach(function(client)
            copilot_cmp._on_insert_enter({})
          end, "copilot")
        end,
      },
    },
    ---@param opts cmp.ConfigSchema  -- Annotate opts parameter for better understanding of its type
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 2,
      })

      -- Define a function to check if there are non-whitespace characters before the cursor
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip") -- Load the LuaSnip library for snippet support
      local cmp = require("cmp") -- Load the nvim-cmp library for completion support

      -- Extend default key mappings with custom behavior
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        -- Map <Tab> to handle multiple scenarios based on the context
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump() -- Expand or navigate snippets if possible
          elseif cmp.visible() then
            cmp.confirm({ select = true }) -- Select the highlighted completion item if the menu is visible
          elseif has_words_before() then
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            local line_content = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
            if line_content:sub(1, col):match("%S+$") then -- Trigger completion if there are suitable characters before the cursor
              cmp.complete()
            else
              -- Indent the line if the cursor is after whitespace or at the line start
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-t>", true, true, true), "n", true)
            end
          else
            -- Fallback to indenting the line when no other conditions are met
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-t>", true, true, true), "n", true)
          end
        end, { "i", "s" }), -- Apply the mapping in insert and select modes

        -- Map <S-Tab> to navigate in the opposite direction of <Tab>
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item() -- Select the previous item in the completion menu
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1) -- Navigate to the previous snippet placeholder if possible
          else
            fallback() -- Default behavior of <S-Tab>
          end
        end, { "i", "s" }), -- Apply the mapping in insert and select modes
      })
    end,
  },
}
