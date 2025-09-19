return {
  "mbbill/undotree",

  init = function()
    vim.keymap.set("n", "<leader><F5>", "<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>")
    vim.g.undotree_WindowLayout = 3
  end,
}
