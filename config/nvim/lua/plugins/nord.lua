--return {
--  'rmehri01/onenord.nvim',
--  config = function()
--    require("onenord").setup()
--  end
--}

return {
  "EdenEast/nightfox.nvim",
  enabled = false,
  config = function()
    require('nightfox').setup()
    vim.cmd("colorscheme nordfox")
  end
}
