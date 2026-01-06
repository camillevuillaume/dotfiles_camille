return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "javascript", "typescript", "css", "html", "json", "yaml", "markdown" },
        }),
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.diagnostics.shellharden,
      },
    })
    
    require("mason-null-ls").setup({
      ensure_installed = {
        "stylua",
        "black",
        "isort",
        "pylint",
        "prettier",
        "shfmt",
        "shellharden",
      },
      automatic_installation = true,
    })
    
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
