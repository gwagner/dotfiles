return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    height = 8,
    padding = false,
  },
  keys = {
    {
      "<leader>e", ":lua vim.diagnostic.open_float()<CR>", desc = "Open Diagnostics in a Floating Window"
    },
    {
      "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Open Trouble"
    },
  },
}
