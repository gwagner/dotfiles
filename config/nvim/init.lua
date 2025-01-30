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
package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/?.lua;"

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

-- Soft line breaks
vim.o.linebreak = true

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

-- Extra nvim-cmp theme data
require("includes.cmp-supplemental")

-- Extra funcs
require("includes.funcs")

-- always use the system clipboard
vim.opt.clipboard = "unnamedplus"

-- set ignorecase/smartcase for searching
vim.opt.ignorecase = true -- Ignore case letters when search
vim.opt.smartcase = true  -- Ignore lowercase for the whole pattern

-- enable shift-tab to outdent
vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- Enable hjkl in insert mode
vim.keymap.set("i", "<C-h>", "<Left>", { silent = true, nowait = true })
vim.keymap.set("i", "<C-j>", "<Down>", { silent = true, nowait = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true, nowait = true })
vim.keymap.set("i", "<C-l>", "<Right>", { silent = true, nowait = true })


-- Enable wb in insert mode
vim.keymap.set("i", "<C-w>", "<C-o>w", { silent = true, nowait = true })
vim.keymap.set("i", "<C-b>", "<C-o>b", { silent = true, nowait = true })

-- Exit terminal and move back to other open window
vim.keymap.set('t', '<ESC>', "<C-\\><C-N><C-W>w", { silent = true })
vim.keymap.set('t', '<C-h>', "<C-\\><C-N><C-w>h", { silent = true })
vim.keymap.set('t', '<C-j>', "<C-\\><C-N><C-w>j", { silent = true })
vim.keymap.set('t', '<C-k>', "<C-\\><C-N><C-w>k", { silent = true })
vim.keymap.set('t', '<C-l>', "<C-\\><C-N><C-w>l", { silent = true })

-- Remove Line Numbers in the Terminal
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd(":setlocal nonumber norelativenumber")
    end
  end
})

-- Automatically enter insert mode when moving to a terminal
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd(":startinsert")
    end
  end
})


-- Allow for ESC to leave quick fix window
function LeaveQuickfixOnEscape()
  local buf_type = vim.bo.filetype
  if buf_type == "qf" then
    vim.api.nvim_command("bd")
  end
end

vim.keymap.set('n', '<ESC>', function()
  LeaveQuickfixOnEscape()
end, { silent = true })


local lua_pattern = { '*.lua' }
local markdown_pattern = { '*.md' }
local markup_pattern = { "*.json", "*.yml", "*.yaml" }
local typescript_pattern = { '*.js', '*.ts', '*.tsx' }
local zig_pattern = { '*.zig', '*.zon' }

-- Format on write
local format_on_save_pattern = {}
tableMerge(format_on_save_pattern, lua_pattern, markup_pattern, typescript_pattern, zig_pattern)
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = format_on_save_pattern,
  callback = function()
    vim.lsp.buf.format()
  end,
})


-- Disable Wrapping for specific files
local original_wrap = vim.opt.wrap
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = zig_pattern,
  callback = function()
    vim.opt.wrap = false
  end,
})

vim.api.nvim_create_autocmd('BufLeave', {
  pattern = zig_pattern,
  callback = function()
    vim.opt.wrap = original_wrap
  end,
})


-- Setup some markdown specific commands
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = markdown_pattern,
  callback = function()
    require('cmp').setup.buffer { enabled = false }
  end,
})

vim.api.nvim_create_autocmd('BufLeave', {
  pattern = markdown_pattern,
  callback = function()
    require('cmp').setup.buffer { enabled = true }
  end,
})


-- Recenter the screen on entering insert
vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup('center_on_insert', {}),
  pattern = '*',
  callback = function()
    vim.cmd.normal({ bang = true, "zz" })
  end,
})


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


-- clear FileExplorer appropriately to prevent netrw from launching on folders
-- netrw may or may not be loaded before telescope-file-browser config
-- conceptual credits to nvim-tree
pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  once = true,
  callback = function()
    pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("telescope-file-browser.nvim", { clear = true }),
  pattern = "*",
  callback = function()
    vim.schedule(function()
      if vim.bo[0].filetype == "netrw" then
        return
      end
      local bufname = vim.api.nvim_buf_get_name(0)
      if vim.fn.isdirectory(bufname) == 0 then
        _, netrw_bufname = pcall(vim.fn.expand, "#:p:h")
        return
      end

      -- prevents reopening of file-browser if exiting without selecting a file
      if netrw_bufname == bufname then
        netrw_bufname = nil
        return
      else
        netrw_bufname = bufname
      end

      -- ensure no buffers remain with the directory name
      vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")

      require("telescope.builtin").find_files({
        cwd = vim.fn.expand "%:p:h",
      })
    end)
  end,
  desc = "telescope.builtin.find_files replacement for netrw",
})


-- always start neotree
-- vim.api.nvim_create_augroup("neotree", {})
-- vim.api.nvim_create_autocmd("VimEnter", {
--   desc = "Open Neotree automatically",
--   group = "neotree",
--   callback = function()
--     if vim.fn.argc() == 0 then
--       vim.cmd "Neotree show"
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd("TabEnter", {
--   desc = "Open Neotree automatically",
--   group = "neotree",
--   callback = function()
--     if vim.fn.argc() == 0 then
--       vim.cmd "Neotree show"
--     end
--   end,
-- })
--
