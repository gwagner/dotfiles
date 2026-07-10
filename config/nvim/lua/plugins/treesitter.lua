-- return {
-- 'nvim-treesitter/nvim-treesitter',
-- dependencies = {
--    'nvim-treesitter/nvim-treesitter-context',
--    "OXY2DEV/markview.nvim",
--  },
--  branch = "main",
--  opts = {
--      folds = {
--        enable = true,
--      },
--      auto_install = true,
--      sync_install = false,
--      ignore_install = {},
--      ensure_installed = {
--        "go", "gomod", "gowork", "gotmpl", "css", "html", "javascript", "typescript", "jsdoc", "json", "c", "java",
--        "toml", "tsx",
--        "lua", "cpp", "python", "rust", "jsonc", "dart", "css", "yaml", "vue", "markdown", "markdown_inline", "php",
--        "php_only", "latex", "typst", "zig", "sql", "comment"
--      },
--      highlight = {
--        enable = true,
--      }
--  },
--  config = function()

--    local context = require("treesitter-context");
--    context.setup({
--      enabled = true,
--    });
--  end
--}

return {
  "romus204/tree-sitter-manager.nvim",
  dependencies = {}, -- tree-sitter CLI must be installed system-wide
  config = function()
    require("tree-sitter-manager").setup({
      ensure_installed = {
        "go", "gomod", "gowork", "gotmpl", "css", "html", "javascript", "typescript", "jsdoc", "json", "c", "java",
        "toml", "tsx",
        "lua", "cpp", "python", "rust", "jsonc", "dart", "css", "yaml", "vue", "markdown", "markdown_inline", "php",
        "php_only", "latex", "typst", "zig", "sql", "comment"
      },
    })
  end,
}
