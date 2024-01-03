return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    height = 5,
  },
  keys = {
    { "<leader>tt", ":TroubleToggle<CR>", desc = "Open Trouble" },
  },
}
