return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    'rafamadriz/friendly-snippets',
    "xzbdmw/colorful-menu.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua",
    },
    {
      'Kaiser-Yang/blink-cmp-dictionary',
      ft = "md",
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },

  -- use a release tag to download pre-built binaries
  version = 'v0.11.0',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',


  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = "default",
      ['<CR>'] = { "select_and_accept", "fallback" },
      ['<S-Tab>'] = { 'select_prev', "snippet_backward", "fallback" },
      ['<Tab>'] = { 'select_next', "snippet_forward", "fallback" },
      ['<C-e>'] = { 'cancel', 'fallback' },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = true } },
      -- Show documentation when selecting a completion item
      documentation = { auto_show = true, auto_show_delay_ms = 200 },

      -- Display a preview of the selected item on the current line
      ghost_text = { enabled = true },

      menu = {
        draw = {
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = function(ctx)
        local success, node = pcall(vim.treesitter.get_node)
        if vim.bo.filetype == 'lua' then
          return { 'lazydev', 'lsp', 'path' }
        elseif vim.bo.filetype == 'md' or vim.bo.filetype == "markdown" then
          return { 'dictionary' }
        elseif success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
          return { "buffer" }
        else
          return { 'lsp', 'path', 'snippets', 'buffer' }
        end
      end,
      cmdline = {},
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          min_keyword_length = 3,
        },
      },
    },
    signature = { enabled = true },
  },

}
