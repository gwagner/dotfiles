return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'windwp/nvim-autopairs'
  },
  cond = not os.getenv("NVIM_DIFF"),
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = true,
      },
      sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer" },
        { name = "luasnip" },
      },
      mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(function(fallback)
          local col = vim.fn.col('.') - 1

          if cmp.visible() then
            cmp.select_next_item(select_opts)
          elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            fallback()
          else
            cmp.complete()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(select_opts)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })),
      },
    })

    local handlers = require('nvim-autopairs.completion.handlers')
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done({
        filetypes = {
          -- "*" is a alias to all filetypes
          ["*"] = {
            ["("] = {
              kind = {
                cmp.lsp.CompletionItemKind.Function,
                cmp.lsp.CompletionItemKind.Method,
              },
              handler = handlers["*"]
            }
          },
        }
      })
    )
  end,
}
