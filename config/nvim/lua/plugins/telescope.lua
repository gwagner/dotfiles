return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "BurntSushi/ripgrep",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>fo", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",   desc = "Open File Browser" },
    { "<leader>ff", ":Telescope find_files select_buffer=true<CR>",                desc = "Find Files" },
    { "<leader>fg", ":Telescope live_grep select_buffer=true<CR>",                 desc = "Find Files" },
    { "<leader>ob", ":Telescope buffers select_buffer=true<CR>",                   desc = "Open Buffer" },
    { "<leader>bo", ":Telescope buffers select_buffer=true<CR>",                   desc = "Open Buffer" },
    { "<leader>fb", ":Telescope current_buffer_fuzzy_find select_buffer=true<CR>", desc = "Fuzzy Find in Buffer" },
  }
}
