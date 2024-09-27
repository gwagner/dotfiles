return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
    servers = {
      clangd = {
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            "Makefile",
            "configure.ac",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja"
          )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
            fname
          ) or require("lspconfig.util").find_git_ancestor(fname)
        end,
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },
      setup = {
        clangd = function(_, opts)
          local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end
      }
    }
  },
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
    lspconfig.dockerls.setup {}
    lspconfig.clangd.setup {}
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
    lspconfig.intelephense.setup {}
    lspconfig.twiggy_language_server.setup {}
    lspconfig.marksman.setup {
      root_dir = function(fname)
        local util = require 'lspconfig.util'
        local root_files = { '.marksman.toml' }
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
      end,
    }
    lspconfig.nginx_language_server.setup {}
    lspconfig.jsonls.setup {}
    lspconfig.lua_ls.setup {}
    lspconfig.tailwindcss.setup {}
    lspconfig.yamlls.setup {}
  end,
}
