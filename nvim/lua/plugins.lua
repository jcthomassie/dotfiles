local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/.plugins')

Plug 'navarasu/onedark.nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')


require('onedark').load()
require('nvim-treesitter.configs').setup {
    ensure_installed = { "bash", "python", "rust", "yaml", "json" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      enable = true,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }