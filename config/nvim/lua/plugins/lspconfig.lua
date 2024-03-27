return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
  },
  dependencies = {
    "williamboman/mason.nvim",
    'simrat39/inlay-hints.nvim'
  },

  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local ih = require("inlay-hints")
    mason.setup()

    -- Setup Language Server
    require 'lspconfig'.ansiblels.setup {}
    require 'lspconfig'.gopls.setup {
      on_attach = function(c, b)
        ih.on_attach(c, b)
      end,
      filetypes = { 'go', 'gomod', 'gowork' },
      settings = {
        gopls = {
          hints = {
            rangeVariableTypes = true,
            parameterNames = true,
            constantValues = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            functionTypeParameters = true,
          },
        }
      }
    }
    require 'lspconfig'.bashls.setup {}
    require 'lspconfig'.html.setup {}
    require 'lspconfig'.marksman.setup {
      root_dir = function(fname)
        local util = require 'lspconfig.util'
        local root_files = { '.marksman.toml' }
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
      end,
    }
    require 'lspconfig'.jsonls.setup {}
    require 'lspconfig'.lua_ls.setup {}
    require 'lspconfig'.tailwindcss.setup {}
    require 'lspconfig'.yamlls.setup {}
  end,
}
