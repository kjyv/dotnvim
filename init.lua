-- Get this file's location
local path = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand("<sfile>:p")), ":h")

-- Get OS name
local os_name = vim.loop.os_uname().sysname

-- Source config files
if os_name == "Darwin" then
  vim.cmd("source " .. path .. "/macos.vim")
end
vim.cmd("source " .. path .. "/editing.vim")
vim.cmd("source " .. path .. "/interface.vim")
vim.cmd("source " .. path .. "/stripWhitespace.vim")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- make sure venv python is used
vim.g.python3_host_prog = vim.fn.getcwd() .. "/.venv/bin/python"
vim.env.PATH = vim.fn.getcwd() .. "/.venv/bin:" .. vim.env.PATH

-- Plugins (Bootstrap lazy.nvim if not installed)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin Setup with lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins-movement" },
    { import = "plugins-editing" },
    { import = "plugins-ui" },
    { import = "plugins-lsp" },
    -- TODO
    -- try nvim-tree
    -- try gitsigns
  }
}
)

-- local cmp = require'cmp'
-- cmp.setup({
--   completion = {
--     autocomplete = { require'cmp.types'.cmp.TriggerEvent.TextChanged },
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Confirm explicitly with Enter
--     ['<Tab>'] = cmp.mapping.select_next_item(),         -- Tab still works if you need
--     ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--   }),
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     -- { name = 'path' },
--     -- { name = 'buffer' },
--   })
-- })

-- require("noice").setup({
--   cmdline = {
--     enabled = true,
--     view = "cmdline_popup", -- Enables the floating command line
--     format = {
--       cmdline = { pattern = "^:", icon = "", lang = "vim" },
--       search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
--       search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
--     },
--   }
-- })
--
