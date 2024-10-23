return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  dependencies = {
    "BurntSushi/ripgrep",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>fo", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",   desc = "Open File Browser" },
    { "<leader>ff", ":Telescope find_files select_buffer=true<CR>",                desc = "Find Files (Fuzzy)" },
    { "<leader>fg", ":Telescope live_grep select_buffer=true<CR>",                 desc = "Find Files (Grep)" },
    { "<leader>ob", ":Telescope buffers select_buffer=true<CR>",                   desc = "Open Buffer" },
    { "<leader>fb", ":Telescope current_buffer_fuzzy_find select_buffer=true<CR>", desc = "Fuzzy Find in Buffer" },
  },
  config = function()
    require("telescope").setup {
      extensions = {
        file_browser = {
          -- hijack_netrw = true,
        }
      }
    }

    require("telescope").load_extension("file_browser")
  end
}
