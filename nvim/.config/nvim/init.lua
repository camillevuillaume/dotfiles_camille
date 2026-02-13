require("vim-options")
vim.g.maplocalleader = "\\"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Setup lazy.nvim
require("lazy").setup("plugins")

vim.api.nvim_set_hl(0, "@lsp.type.string", {})
vim.api.nvim_set_hl(0, "@lsp.type.string", {})

vim.cmd([[colorscheme tokyonight-night]])

-- Enable virtual text for diagnostics
vim.diagnostic.config({ virtual_text = true })

-- Enable mouse
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true

-- remap movement keys
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
vim.keymap.set("n", "<C-Right>", "<C-w>l")

vim.opt.number = true
vim.opt.relativenumber = true

local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

-- Yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')  -- yank motion
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y')  -- yank line
vim.keymap.set({ "n", "v" }, "<leader>yy", '"+Y') -- yank line

-- Delete into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d')  -- delete motion
vim.keymap.set({ "n", "v" }, "<leader>D", '"+D')  -- delete line
vim.keymap.set({ "n", "v" }, "<leader>dd", '"+D') -- delete line

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p') -- paste after cursor
vim.keymap.set("n", "<leader>P", '"+P') -- paste before cursor

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  group = numbertoggle,
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "copilot-chat" then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  group = numbertoggle,
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "copilot-chat" then
      vim.opt.relativenumber = false
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-chat",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end,
})
