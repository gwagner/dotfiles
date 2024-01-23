local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Change the leader key from the default ; to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Setup tabs to only be 2 spaces instead of 4-5
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.bo.softtabstop = 2

-- Add highlighting to the line that the cursor is on
vim.opt.cursorline = true

-- Show Line Numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable Spellcheck
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

require("lazy").setup("plugins")

-- Setup rooter to automatically change my root
require("rooter")

-- Setup LSP change when working on HUGO files
--require("hugolsp")

-- Setup Theme
require('onenord').setup()

-- Setup Language Server
require 'lspconfig'.ansiblels.setup {}
require 'lspconfig'.gopls.setup {
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl', 'html' }
}
require 'lspconfig'.bashls.setup {}
require 'lspconfig'.html.setup {}
require 'lspconfig'.marksman.setup {}
require 'lspconfig'.jsonls.setup {}
require 'lspconfig'.lua_ls.setup {}
require 'lspconfig'.pylsp.setup {}
require 'lspconfig'.yamlls.setup {}

-- enable shift-tab to outdent
vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- Auto format LUA
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- Auto format python
-- vim.g.python3_host_prog = '/home/gwagner/.pyenv/versions/neovim3/bin/python'
-- vim.cmd [[autocmd BufWritePre *.py python vim.lsp.buf.format()]]

-- Setup autoread from disk on change
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- always use the system clipboard
vim.opt.clipboard = "unnamedplus"
