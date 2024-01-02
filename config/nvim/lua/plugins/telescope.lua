return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = { 
    { "<leader>fo", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "Open File Browser" },
    { "<leader>ff", ":Telescope find_files select_buffer=true<CR>", desc = "Find Files" }
  }
}
