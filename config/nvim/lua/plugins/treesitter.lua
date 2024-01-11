return {
	'nvim-treesitter/nvim-treesitter',
  config = function() 
    local configs = require("nvim-treesitter.configs")
     configs.setup({
     ensure_installed = {
      "go", "gomod", "gowork", "css", "html", "javascript", "typescript", "jsdoc", "json", "c", "java", "toml", "tsx",
      "lua", "cpp", "python", "rust", "jsonc", "dart", "css", "yaml", "vue"
    }
  })
  end
}
