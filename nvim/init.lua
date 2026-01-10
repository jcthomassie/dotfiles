-- Whitespace
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = true
vim.opt.backspace = "indent,eol,start"

-- Style
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Misc
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"

require('plugins')
require('mappings')
