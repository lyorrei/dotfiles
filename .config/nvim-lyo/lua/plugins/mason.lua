if true then
  return {}
end

return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local ensure_installed = {
        "lua-language-server",
        "prettier", -- prettier formatter
        "prettierd",
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
        "eslint-lsp", -- js linter
        "goimports", -- golang formatter
        "rust-analyzer",
        "css-lsp",
        "emmet-ls",
        "gopls",
        "graphql-language-service-cli",
        "html-lsp",
        "prismals",
        "pyright",
        "tailwindcss",
        "tsserver",
        "docker_compose_language-service",
        "dockerls",
      }

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = ensure_installed,
      })

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
      end, {})
    end,
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
  },
}
