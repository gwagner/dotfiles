return {
  "gbprod/yanky.nvim",
  dependencies = {
    { "kkharji/sqlite.lua" },
  },
  opts = {
    ring = {
      storage = "sqlite",
      storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
    }
  },
  keys = {
    { "p",          "<Plug>(YankyPutAfter)",       mode = { "n", "x" },   desc = "Yanky Put After" },
    { "P",          "<Plug>(YankyPutBefore)",      mode = { "n", "x" },   desc = "Yanky Put Before" },
    { "y",          "<Plug>(YankyYank)",           mode = { "n", "x" },   desc = "Yanky Yank" },
    { "<leader>yb", ":Telescope yank_history<CR>", desc = "Yanky History" },
  },
}
