return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate', -- Ensures parsers are updated on plugin updates
  opts =   {
    ensure_installed = { 'c', 'lua', 'python', 'javascript', 'yaml', 'markdown' },
  },
}
