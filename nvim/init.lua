-- Whitespace
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = true
vim.opt.backspace = "indent,eol,start"

-- Style
vim.opt.ruler = true
vim.opt.number = true
vim.api.nvim_command([[
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
]])

require('plugins')
require('mappings')
