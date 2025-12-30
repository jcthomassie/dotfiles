-- Lazy bootstrap
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

-- Lazy dependency spec
require("lazy").setup({
    'akinsho/git-conflict.nvim',
    'akinsho/toggleterm.nvim',
    'feline-nvim/feline.nvim',
    'fladson/vim-kitty',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/nvim-cmp',
    'kyazdani42/nvim-tree.lua', 
    'kyazdani42/nvim-web-devicons',
    'lewis6991/impatient.nvim',
    'lewis6991/gitsigns.nvim',
    'mtdl9/vim-log-highlighting',
    'navarasu/onedark.nvim',
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'nvim-telescope/telescope.nvim',
    {
        'mrcjkb/rustaceanvim',
        version = '^5',
        lazy = false,
    },
    {
        'nvim-treesitter/nvim-treesitter', 
        build = ':TSUpdate',
    },
})

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

-- Rust LSP config: https://github.com/mrcjkb/rustaceanvim
vim.g.rustaceanvim = {
    server = {
        default_settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

-- Python LSP config (Neovim 0.11+ native API)
vim.lsp.config('pyright', {})
vim.lsp.enable('pyright')

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

-- Log syntax config
local log_syntax = vim.api.nvim_create_augroup("log_syntax", { clear = true })
vim.api.nvim_create_autocmd("Syntax", {
    pattern = "log",
    group = log_syntax,
    command = "syn match logDate '^\\d\\{2}-\\d\\{2}'",
})
vim.api.nvim_create_autocmd("Syntax", {
    pattern = "log",
    group = log_syntax,
    command = "syn keyword logLevelDebug D",
})
vim.api.nvim_create_autocmd("Syntax", {
    pattern = "log",
    group = log_syntax,
    command = "syn keyword logLevelInfo I",
})
vim.api.nvim_create_autocmd("Syntax", {
    pattern = "log",
    group = log_syntax,
    command = "syn keyword logLevelWarning W",
})
vim.api.nvim_create_autocmd("Syntax", {
    pattern = "log",
    group = log_syntax,
    command = "syn keyword logLevelError E",
})

-- nvim-tree startup config
local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1
  if not directory then
    return
  end

  vim.cmd.cd(data.file)
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

