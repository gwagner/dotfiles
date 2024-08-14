return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
  },
  keys = {
    --{ "<leader>ca", vim.lsp.buf.code_action, desc = "LSP Code Action" },
    --    { "<leader>hh", vim.lsp.buf.hover,       desc = "LSP Type Definition" },
  },
  --  on_attach = function(c, b)
  --    if c.server_capabilities.inlayHintProvider then
  --      vim.lsp.inlay_hint.enable(b, true)
  --    end
  --  end,
  dependencies = {
    "williamboman/mason.nvim",
    'simrat39/inlay-hints.nvim'
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    --local ih = require("inlay-hints")
    mason.setup()

    -- Setup Language Server
    lspconfig.ansiblels.setup {}
    lspconfig.gopls.setup {
      --on_attach = function(c, b)
      --  ih.on_attach(c, b)
      --end,
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
    lspconfig.bashls.setup {}
    lspconfig.html.setup {}
    lspconfig.marksman.setup {
      root_dir = function(fname)
        local util = require 'lspconfig.util'
        local root_files = { '.marksman.toml' }
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
      end,
    }
    lspconfig.jsonls.setup {}
    lspconfig.lua_ls.setup {}
    lspconfig.tailwindcss.setup {}
    lspconfig.yamlls.setup {}
  end,
}
