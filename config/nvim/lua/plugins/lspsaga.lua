return {
  'nvimdev/lspsaga.nvim',
  enabled = false,
  config = function()
    require('lspsaga').setup({})
  end,
  keys = {
    { "<leader>hh", '<cmd>Lspsaga hover_doc<CR>',      desc = "lspsaga Hover" },
    { "<leader>fr", '<cmd>Lspsaga finder def+ref<CR>', desc = "lspsaga Finder" },
    { "<leader>ca", '<cmd>Lspsaga code_action<CR>',    desc = "lspsaga Code Action" }
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons'      -- optional
  }
}
