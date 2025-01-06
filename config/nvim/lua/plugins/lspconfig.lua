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
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local masonLspConfig = require("mason-lspconfig")
    local util = require("lspconfig.util")

    mason.setup()
    masonLspConfig.setup({
      ensure_installed = { "ansiblels", "clangd", "dockerls", "emmet_language_server", "eslint", "gopls",
        "html", "intelephense", "jsonls", "lua_ls", "marksman", "nginx_language_server", "pylsp",
        "tailwindcss", "twiggy_language_server", "ts_ls", "yamlls", "zls" }
    })

    -- Get the local capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Add in the cmp capabilities
    for k, v in pairs(require('cmp_nvim_lsp').default_capabilities()) do capabilities[k] = v end

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Setup Language Server
    lspconfig.ansiblels.setup {
      capabilities = capabilities,
    }
    lspconfig.dockerls.setup {
      capabilities = capabilities,
    }
    lspconfig.clangd.setup {
      capabilities = capabilities,
    }
    lspconfig.gopls.setup {
      capabilities = capabilities,
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      settings = {
        gopls = {
          usePlaceholders = true,
          analyses = {
            unusedvariable = true,
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
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
    lspconfig.bashls.setup {
      capabilities = capabilities,
    }

    lspconfig.html.setup {
      capabilities = capabilities,
      filetypes = { 'html', 'templ', 'twig' },
      provideFormatter = false,
      root_dir = util.root_pattern('composer.json', 'package.json', '.git'),
    }
    lspconfig.eslint.setup {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    }
    lspconfig.ts_ls.setup {
      capabilities = capabilities,
      settings = {
        diagnostics = { ignoredCodes = { 2604 } }
      },
      root_dir = util.root_pattern(".git"),
    }
    lspconfig.intelephense.setup {
      capabilities = capabilities,
    }
    lspconfig.twiggy_language_server.setup {
      capabilities = capabilities,
    }
    lspconfig.marksman.setup {
      capabilities = capabilities,
      root_dir = function(fname)
        local util = require 'lspconfig.util'
        local root_files = { '.marksman.toml' }
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
      end,
    }
    lspconfig.nginx_language_server.setup {
      capabilities = capabilities,
    }
    lspconfig.jsonls.setup {
      capabilities = capabilities,
    }
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
    }
    lspconfig.tailwindcss.setup {
      capabilities = capabilities,
    }
    lspconfig.yamlls.setup {
      capabilities = capabilities,
    }
    lspconfig.zls.setup {
      capabilities = capabilities,
    }
  end,
}
