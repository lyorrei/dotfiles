return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_mouse_mappings = 1

      vim.g.VM_maps = {
        ["Select Cursor Down"] = "<C-M-Down>",
        ["Select Cursor Up"] = "<C-M-Up>",
      }
      -- Set basic mouse mappings for vim-visual-multi
      vim.g.VM_mouse_mappings = 1

      -- Custom mouse mappings
      vim.api.nvim_set_keymap("n", "<M-LeftMouse>", "<Plug>(VM-Mouse-Cursor)", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<M-RightMouse>", "<Plug>(VM-Mouse-Word)", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<M-C-RightMouse>", "<Plug>(VM-Mouse-Column)", { noremap = true, silent = true })
    end,
  },
}
