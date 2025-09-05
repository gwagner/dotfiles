return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    "OXY2DEV/markview.nvim",
  },
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      auto_install = true,
      sync_install = false,
      ignore_install = {},
      ensure_installed = {
        "go", "gomod", "gowork", "css", "html", "javascript", "typescript", "jsdoc", "json", "c", "java", "toml", "tsx",
        "lua", "cpp", "python", "rust", "jsonc", "dart", "css", "yaml", "vue", "markdown", "markdown_inline", "php",
        "php_only", "latex", "typst", "zig", "sql", "comment"
      },
      highlight = {
        enable = true,
      }
    })

    local context = require("treesitter-context");
    context.setup({
      enabled = true,
    });
  end
}
