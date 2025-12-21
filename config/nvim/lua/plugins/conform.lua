return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      javascript = {
        "prettier"
      },
      typescript = {
        "prettier"
      },
      css = {
        "prettier"
      },
      html = {
        "prettier"
      },
    },
    format_on_save = {
      timout_ms = 500,
      lsp_format = "fallback",
    },
    formatters = {
      prettier = {
        append_args = function(self, ctx)
          if vim.endswith(ctx.filename, ".tmpl") then
            return { "--parser", "html" }
          end
        end,
      },
    },
  },
}
