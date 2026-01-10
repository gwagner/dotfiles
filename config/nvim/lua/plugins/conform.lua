return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  keys = {
    { "<leader>fc", function() require("conform").format() end, mode = { 'n' }, desc = "Format Current Buffer" },
  },
  opts = {
    log_level = vim.log.levels.DEBUG,
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
      sql = {
        "sqlfmt"
      },
    },
    format_on_save = function(bufnr)
      -- Disable file formatting on any temporary buffer contents
      local ignore_filetypes = { "go" }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end

      local no_fallback = { "javascript" }

      if vim.tbl_contains(no_fallback, vim.bo[bufnr].filetype) then
        return {
          timeout_ms = 2500,
          lsp_fallback = false,
        }
      end

      return {
        timeout_ms = 2500,
        lsp_fallback = true,
      }
    end,
    formatters = {
      prettier = {
        append_args = function(self, ctx)
          if vim.endswith(ctx.filename, ".tmpl") then
            return { "--parser", "html" }
          end
          return {}
        end,
      },
    },
  },
}
