local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/.plugins')

Plug 'akinsho/git-conflict.nvim'
Plug 'feline-nvim/feline.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'simrat39/rust-tools.nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')

require('onedark').load()
require('feline').setup()
require('gitsigns').setup()
require('git-conflict').setup()
require('nvim-tree').setup()
require('nvim-treesitter.configs').setup {
    ensure_installed = { "bash", "python", "rust", "yaml", "json", "lua" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
require('rust-tools').setup({
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
})
