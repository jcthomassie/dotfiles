local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/.plugins')

Plug 'navarasu/onedark.nvim'
Plug 'feline-nvim/feline.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')

require('onedark').load()
require('feline').setup()
require('gitsigns').setup()
require("nvim-tree").setup()
require('nvim-treesitter.configs').setup {
    ensure_installed = { "bash", "python", "rust", "yaml", "json", "lua" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
