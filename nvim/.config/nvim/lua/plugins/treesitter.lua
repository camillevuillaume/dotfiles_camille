return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate', -- Ensures parsers are updated on plugin updates
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'c', 'lua', 'python', 'javascript', 'yaml' }, -- Specify languages to install parsers for
      highlight = {
        enable = true, additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      -- Add other configurations as needed
    }
  end
}
