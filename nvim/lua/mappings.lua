vim.api.nvim_exec(
[[
" Line swapping functions
function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

" Key mappings
noremap <silent> <c-s-up> :call <SID>swap_up()<CR>
noremap <silent> <c-s-down> :call <SID>swap_down()<CR>
]],
true)

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('v', '<TAB>', '>gv', opts)
vim.api.nvim_set_keymap('v', '<S-TAB>', '<gv', opts)

vim.api.nvim_set_keymap('n', '<c-k>', ':wincmd k<CR>', opts)
vim.api.nvim_set_keymap('n', '<c-j>', ':wincmd j<CR>', opts)
vim.api.nvim_set_keymap('n', '<c-h>', ':wincmd h<CR>', opts)
vim.api.nvim_set_keymap('n', '<c-l>', ':wincmd l<CR>', opts)

vim.api.nvim_set_keymap('n', '<c-o>', ':Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<c-f>', ':Telescope live_grep<CR>', opts)


