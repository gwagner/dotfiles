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

    mason.setup({
      ensure_installed = {
        "ansible-lint"
      }
    });
    masonLspConfig.setup({
      automatic_installation = true,
      ensure_installed = { "ansiblels", "clangd", "dockerls", "emmet_language_server", "eslint", "gopls",
        "html", "intelephense", "jsonls", "lua_ls", "marksman", "pylsp",
        "tailwindcss", "twiggy_language_server", "ts_ls", "yamlls", "zls" }
    })

    -- Get the local capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Add in the cmp capabilities
    -- for k, v in pairs(require('cmp_nvim_lsp').default_capabilities()) do capabilities[k] = v end
    for k, v in pairs(require('blink.cmp').get_lsp_capabilities()) do capabilities[k] = v end

    capabilities.textDocument.completion.completionItem.snippetSupport = true


    vim.lsp.config('*', {
      capabilities = capabilities,
    })


    vim.lsp.config('gopls', {
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
    })

    vim.lsp.config('html', {
      filetypes = { 'html', 'templ', 'twig' },
      provideFormatter = false,
      root_dir = util.root_pattern('composer.json', 'package.json', '.git'),
    })

    vim.lsp.config('eslint', {
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    })

    vim.lsp.config('ts_ls', {
      settings = {
        diagnostics = { ignoredCodes = { 2604 } }
      },
      root_dir = util.root_pattern(".git"),
    })

    vim.lsp.config("zls", {
      settings = {
        enable_build_on_save = true,
      },
    })
    vim.lsp.enable("ansiblels")
    vim.lsp.enable("bashls")
    vim.lsp.enable("clangd")
    vim.lsp.enable("dockerls")
    vim.lsp.enable("eslint")
    vim.lsp.enable("gopls")
    vim.lsp.enable("html")
    vim.lsp.enable("jsonls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("tailwindcss")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("yamlls")
    vim.lsp.enable("zls")
  end,
}
