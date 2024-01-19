return {
  "andrewferrier/wrapping.nvim",
  config = function()
    require("wrapping").setup({
      auto_set_mode_filetype_allowlist = {
        "markdown",
        "text",
      },
    })
  end
}
