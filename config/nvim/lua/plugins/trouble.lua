return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    height = 8,
    padding = false,
  },
  keys = {
    { "<leader>tt", ":TroubleToggle<CR>", desc = "Open Trouble" },
  },
}
