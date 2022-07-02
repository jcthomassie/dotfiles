local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/.plugins')

Plug 'feline-nvim/feline.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
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
