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

-- Setup a python provider
vim.g.python3_host_prog = "$HOME/.pyenv/versions/venv/bin/python"

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
vim.opt.signcolumn = "yes"

-- Enable Spellcheck
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

require("lazy").setup("plugins")

-- Setup rooter to automatically change my root
--require("rooter")

-- Setup LSP change when working on HUGO files
--require("hugolsp")

-- enable shift-tab to outdent
vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- Auto format LUA
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- Setup autoread from disk on change
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Disable running diags on node modules
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "**/node_modules/**", "node_modules", "/node_modules/*" },
  callback = function()
    vim.diagnostic.disable(0)
  end,
})

-- Set text width
vim.opt.formatoptions = 'jcroqlnt'
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = { '*.md' },
  callback = function()
    vim.opt.colorcolumn = '120'
    vim.opt.textwidth = 120
  end,
})

vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  pattern = { '*.md' },
  callback = function()
    vim.opt.colorcolumn = ''
    vim.opt.textwidth = 0
  end,
})

-- always use the system clipboard
vim.opt.clipboard = "unnamedplus"

-- always start neotree
vim.api.nvim_create_augroup("neotree", {})
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Open Neotree automatically",
  group = "neotree",
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd "Neotree show"
    end
  end,
})

vim.api.nvim_create_autocmd("TabEnter", {
  desc = "Open Neotree automatically",
  group = "neotree",
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd "Neotree show"
    end
  end,
})
