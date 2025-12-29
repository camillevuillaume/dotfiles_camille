return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pylsp", "clangd", "ts_ls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- local lspconfig = require("lspconfig")
      -- lspconfig.lua_ls.setup({
      --   capabilities = capabilities,
      -- })
      -- lspconfig.pylsp.setup({
      --   capabilities = capabilities,
      -- })
      -- lspconfig.clangd.setup({
      --   capabilities = capabilities,
      -- })
      vim.lsp.enable('pylsp')
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('clangd')
      vim.lsp.enable('ts_ls')

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.diagnostic.config({
        virtual_text = false,
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
          linehl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          },
          numhl = {
            [vim.diagnostic.severity.WARN] = "WarningMsg",
          },
        },
      })
      -- vim.diagnostic.config({ signs = { text = { [vim.diagnostic.severity.INFO] = ""}, texthl = "DiagnosticSignInfo" }})
      -- vim.diagnostic.config({ signs = { text = { [vim.diagnostic.severity.HINT] = ""}, texthl = "DiagnosticSignHint" }})
    end,
  },
}
