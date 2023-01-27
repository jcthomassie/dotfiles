local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/.plugins')

Plug 'akinsho/git-conflict.nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'feline-nvim/feline.nvim'
Plug 'fladson/vim-kitty'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/impatient.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'simrat39/rust-tools.nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')

_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_chunks',
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_modpaths',
  }
}
require('impatient').enable_profile()
require('onedark').load()
require('feline').setup()
require('gitsigns').setup()
require('git-conflict').setup()
require('nvim-tree').setup()
require('nvim-treesitter.configs').setup {
    ensure_installed = { 
        "bash",
        "python",
        "rust",
        "lua",
        "java",
        "json",
        "yaml",
        "toml",
        "markdown",
    },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
require('toggleterm').setup {
    open_mapping = [[<A-t>]],
    insert_mappings = true,
    terminal_mappings = true,
}

-- Rust LSP extended config: https://github.com/simrat39/rust-tools.nvim#configuration
require('rust-tools').setup({
    tools = { -- rust-tools options
        autoSetHints = true,
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

-- Python LSP config
require('lspconfig')['pyright'].setup({})

-- Completions: https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require('cmp')
cmp.setup({
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    },

    -- Installed sources
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
    },
})
