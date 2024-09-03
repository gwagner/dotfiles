return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    height = 8,
    padding = false,
  },
  keys = {
    {
      "<leader>ttf", ":lua vim.diagnostic.open_float()<CR>", "Open Diagnostics in a Floating Window"
    },
    {
      "<leader>tt",
      function()
        if (vim.bo.filetype == "markdown")
        then
          require("trouble").toggle("document_diagnostics")
        else
          require("trouble").toggle("diagnostics")
        end
      end,
      desc = "Open Trouble"
    },
  },
}
