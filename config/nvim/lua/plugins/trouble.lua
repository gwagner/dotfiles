return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    height = 8,
    padding = false,
  },
  keys = {
    --{ "<leader>tt", ":TroubleToggle<CR>", desc = "Open Trouble" },
    {
      "<leader>tt",
      function()
        --if (vim.bo.filetype == "markdown" or vim.bo.filetype == "html")
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
