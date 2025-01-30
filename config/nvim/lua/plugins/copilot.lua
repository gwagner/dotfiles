return {
  "zbirenbaum/copilot.lua",
  enabled = false,
  dependencies = {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end
}
