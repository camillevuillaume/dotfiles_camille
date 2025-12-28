return {
  "romgrk/barbar.nvim",
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    animation = true,
    insert_at_end = true,
    -- …etc.
  },
  keys = {
    -- Navigate between buffers
    { "<A-h>", "<Cmd>BufferPrevious<CR>", desc = "Previous buffer" },
    { "<A-l>", "<Cmd>BufferNext<CR>", desc = "Next buffer" },
    -- Close buffer
    { "<A-c>", "<Cmd>BufferClose<CR>", desc = "Close buffer" },
    -- Find buffer
    { "<A-b>", "<Cmd>BufferPick<CR>", desc = "Pick buffer" },
  },
}

