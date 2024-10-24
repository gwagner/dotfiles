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

-- always use the system clipboard
vim.opt.clipboard = "unnamedplus"

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


vim.keymap.set("i", "<C-f>",
  function()
    vim.ui.input({ prompt = 'Jump to Next: ' }, function(search)
      if not search then
        return
      end
      local keys = vim.api.nvim_replace_termcodes("<C-o>/" .. search .. "<CR>", true, false,
        true)
      vim.api.nvim_feedkeys(keys, "m", true)
    end
    )
  end
)

vim.keymap.set("i", "<C-g>",
  function()
    vim.ui.input({ prompt = 'Jump to Previous: ' }, function(search)
      if not search then
        return
      end
      local keys = vim.api.nvim_replace_termcodes("<C-o>?" .. search .. "<CR>", true, false, true)
      vim.api.nvim_feedkeys(keys, "m", true)
    end
    )
  end
)

-- Auto format LUA
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- Auto format html.twig
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.html', '*.html.twig', '*.js' },
  callback = function()
    vim.lsp.buf.format()
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

local isValidBuffer = function(buf)
  if not buf.bufnr or buf.bufnr < 1 then return false end
  local valid = vim.api.nvim_buf_is_valid(buf.bufnr)
  if not valid then return false end
  return buf.listed == 1
end

local isBufferEmpty = function(buf)
  if vim.api.nvim_buf_is_loaded(buf.bufnr)
      and vim.api.nvim_buf_get_lines(buf.bufnr, 0, -1, true)[1] == ''
      and vim.api.nvim_buf_get_name(buf.bufnr) == ''
      and not vim.api.nvim_buf_get_option(buf.bufnr, 'modified') then
    -- Close the buffer (force delete it)
    return true
  end

  return false
end

-- Function to iterate over all buffers and close unnamed, unedited ones
-- vim.api.nvim_create_autocmd("WinEnter", {
--   callback = function()
--     local buffers = vim.fn.getbufinfo()
--     local valid_buffers = {}
--     local named_buffers = 0
--     -- Find out how many loaded active buffers we have
--     for _, buf in ipairs(buffers) do
--       if isValidBuffer(buf) then
--         table.insert(valid_buffers, buf)
--         if vim.api.nvim_buf_get_name(buf.bufnr) ~= "" then
--           named_buffers = named_buffers + 1
--         end
--       end
--     end
--
--     local current_buffer_name = vim.api.nvim_buf_get_name(0)
--     if current_buffer_name ~= "" then
--       named_buffers = named_buffers + 1
--     end
--
--     --print("")
--     --print("Num Buffers: " .. #valid_buffers)
--     --print("Num Named Buffers: " .. named_buffers)
--
--     if named_buffers <= 1 then
--       return
--     end
--
--     -- If we have more than X buffers active, then we should start to prune
--     -- Get the list of all buffer numbers
--     for _, buf in ipairs(valid_buffers) do
--       --if vim.api.nvim_buf_is_loaded(bufnr) then
--       --print("  Buffer Name(" .. buf.bufnr .. "): " .. vim.api.nvim_buf_get_name(buf.bufnr))
--       --print("    Buffer Lines: " .. #vim.api.nvim_buf_get_lines(buf.bufnr, 0, -1, true))
--       --print("    Buffer Type: " .. vim.api.nvim_buf_get_option(buf.bufnr, "buftype"))
--       --print("    Buffer FT: " .. vim.api.nvim_buf_get_option(buf.bufnr, "filetype"))
--       --end
--       if isBufferEmpty(buf) then
--         --print("Delete empty buffer: " .. buf.bufnr)
--         vim.api.nvim_buf_delete(buf.bufnr, { force = true })
--       end
--     end
--   end,
-- })

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
