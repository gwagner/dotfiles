return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      auto_install = true,
      ensure_installed = {
        "go", "gomod", "gowork", "css", "html", "javascript", "typescript", "jsdoc", "json", "c", "java", "toml", "tsx",
        "lua", "cpp", "python", "rust", "jsonc", "dart", "css", "yaml", "vue", "markdown", "markdown_inline", "php",
        "php_only", "latex", "typst", "zig"
      },
      highlight = {
        enable = true,
      }
    })
  end
}
