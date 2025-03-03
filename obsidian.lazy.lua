vim.opt.conceallevel = 2
vim.opt_local.conceallevel = 2

local function file_exists(filename)
  local f = io.open(filename, "r")
  if f then
    io.close(f)
    return true
  else
    return false
  end
end

if not vim.env.OBSIDIAN_REST_API_KEY or vim.env.OBSIDIAN_REST_API_KEY == "" then
  local API_KEY_FILE = vim.env.HOME .. "/.obsidian-api-key"

  if file_exists(API_KEY_FILE) then
    vim.env.OBSIDIAN_REST_API_KEY = vim.fn.readfile(API_KEY_FILE)[1]
  end
end

vim.keymap.set("n", "gf", function()
  if require("obsidian").util.cursor_on_markdown_link() then
    return "<cmd>ObsidianFollowLink<CR>"
  else
    return "gf"
  end
end, { noremap = false, expr = true })


return {
  {
    "OXY2DEV/markview.nvim", enabled = false,
  },
}
