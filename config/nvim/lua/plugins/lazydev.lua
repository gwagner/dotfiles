return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  --
  --   "saghen/blink.cmp",
  --   enabled = false,
  --   ft = "lua",
  --   opts = {
  --     sources = {
  --       -- add lazydev to your completion providers
  --       completion = {
  --         enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
  --       },
  --       providers = {
  --         -- dont show LuaLS require statements when lazydev has items
  --         lsp = { fallback_for = { "lazydev" } },
  --         lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
  --       },
  --     },
  --   },
  -- }
}