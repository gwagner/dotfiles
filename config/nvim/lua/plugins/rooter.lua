return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      patterns = { ".git", "Makefile", "package.json", "go.work", "go.mod", "go.sum", ".project_root" },
    })
  end
}
