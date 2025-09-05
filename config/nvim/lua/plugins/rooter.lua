return {
  'DrKJeff16/project.nvim',
  dependencies = { -- OPTIONAL
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require("project").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      patterns = { ".git", "Makefile", "package.json", "go.work", "go.mod", "go.sum", ".project_root", ".obsidian" },
    })
  end
}
