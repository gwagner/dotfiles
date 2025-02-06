return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      auto_install = true,
      ensure_installed = {
        "go", "gomod", "gowork", "css", "html", "javascript", "typescript", "jsdoc", "json", "c", "java", "toml", "tsx",
        "lua", "cpp", "python", "rust", "jsonc", "dart", "css", "yaml", "vue", "markdown", "markdown_inline", "php",
        "php_only", "blade", "latex", "typst", "zig"
      },
      highlight = {
        enable = true,
      }
    })

    vim.filetype.add({
      pattern = {
        [".*%.blade%.php"] = "blade",
      },
    })


    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "blade",
    }
  end
}
