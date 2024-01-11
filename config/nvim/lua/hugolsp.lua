vim.api.nvim_create_autocmd(
    {
        "BufNewFile",
        "BufRead",
    },
    {
        pattern = "*.html,*.yaml,*.yml",
        callback = function()
            if vim.fn.search("{{.\\+}}", "nw") ~= 0 then
                local buf = vim.api.nvim_get_current_buf()
                vim.api.nvim_buf_set_option(buf, "filetype", "gohtmltmpl")
            end
        end
    }
)
