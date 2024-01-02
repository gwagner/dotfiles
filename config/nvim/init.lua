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

-- Setup Theme
require('onenord').setup()

-- Setup Language Server
require 'lspconfig'.gopls.setup {}
require 'lspconfig'.bashls.setup {}
require 'lspconfig'.jsonls.setup {}
require 'lspconfig'.marksman.setup {}
require 'lspconfig'.lua_ls.setup {}
require 'lspconfig'.yamlls.setup {}

-- Auto format LUA
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
