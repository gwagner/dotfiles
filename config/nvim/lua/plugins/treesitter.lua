return {
  'nvim-treesitter/nvim-treesitter',
  branch = "main",
  build = ':TSUpdate',
  dependencies = {}, -- tree-sitter CLI must be installed system-wide
  config = function()
    local treesitter = require("nvim-treesitter")
    treesitter.setup()
    treesitter.install({
      "go",
      "gomod",
      "gowork",
      "gotmpl",
      "css",
      "html",
      "javascript",
      "typescript",
      "jsdoc",
      "json",
      "jsonc",
      "c",
      "java",
      "toml",
      "tsx",
      "lua",
      "cpp",
      "python",
      "rust",
      "dart",
      "css",
      "yaml",
      "vue",
      "markdown",
      "markdown_inline",
      "php",
      "php_only",
      "latex",
      "typst",
      "zig",
      "sql",
      "comment",
    })
  end,
}
