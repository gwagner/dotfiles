return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  keys = {
    { "<leader>ha", function() require("harpoon.mark").add_file() end,        desc = "Harpoon Add File" },
    { "<leader>ho", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Open" }
  },
}
