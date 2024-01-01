return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      { "<leader>t", ":Neotree toggle filesystem reveal left dir=%:p:h:h<CR>", desc="Neotree Open"},
      { "<leader>u", ":Neotree dir=../<CR>", desc="Neotree up one directory" },
    }
}
