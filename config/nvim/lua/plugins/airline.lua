return {
  'vim-airline/vim-airline',
  enabled = false,
  dependencies = {
    'vim-airline/vim-airline-themes',
    'ryanoasis/vim-devicons'
  },
  config = function()
    vim.cmd [[AirlineTheme base16]]
  end
}
