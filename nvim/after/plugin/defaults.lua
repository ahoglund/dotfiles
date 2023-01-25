local map = require("utils").map

map('n', '<leader>sb', ':w!<CR>')
map('n', '<leader>w', ':w!<CR>')
map('n', '<leader>cb', 'ZZ<CR>')
map('n', '<leader>e', ":e <C-R>=expand('%:p:h') . '/'<cr>")
map('n', '<leader>vr', "<cmd>lua ReloadConfig()<CR>")
map('n', '<leader>t', ':TestNearest<CR>')
map('n', '<leader>T', ':TestFile<CR>')
map('n', '<leader>a', ':TestSuite<CR>')
map('n', '<leader>l', ':TestLast<CR>')
map('n', '<leader>g', ':TestVisit<CR>')
map('n', '<leader>f', '/<C-R><C-W><CR>')

-- function s:Mkdir()
--   let dir = expand('%:p:h')
--
--   if !isdirectory(dir)
--     call mkdir(dir, 'p')
--     echo 'Created non-existing directory: '.dir
--
-- endfunction
-- Create directory

-- vim.api.nvim_create_autocmd('BufWritePre', {
--   command = 'call s:Mkdir()',
--   pattern = "*",
-- })

-- " strip whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  command = [[%s/\s\+$//e]],
  pattern = "*",
})

-- " convert tabs on save
vim.api.nvim_create_autocmd('BufWritePre', {
  command = [[%s/\t\+/  /e]],
  pattern = { '*.rb', '*.java', '*.kt' },
})

-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
--
-- vim.keymap.set('n', '<leader>t', ':TestNearest<CR>')
-- vim.keymap.set('n', '<leader>T', ':TestFile<CR>')
-- vim.keymap.set('n', '<leader>a', ':TestSuite<CR>')
-- vim.keymap.set('n', '<leader>l', ':TestLast<CR>')
-- vim.keymap.set('n', '<leader>g', ':TestVisit<CR>')
-- nnoremap <leader>y :call system('socat - UNIX-CLIENT:$HOME/.clipper.sock', @0)<CR>

-- vim.keymap.set('n', '<leader>f', '/<C-R><C-W><CR>')
-- nnoremap <Leader>fr :%s/\<<C-r><C-w>\>/
-- vnoremap <Leader>fr "hy:%s/<C-r>h/
--
-- inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
-- inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
-- inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
--
-- nnoremap <C-p> :Files<CR>
-- nmap <silent> <Leader>r :Files<CR>
-- nmap \ :Rg<SPACE>
-- nmap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
-- nmap <Leader>ae :Tabularize /=<CR>
-- vmap <Leader>ae :Tabularize /=<CR>
-- nmap <Leader>ah :Tabularize /:\zs<CR>
-- vmap <Leader>ah :Tabularize /:\zs<CR>
-- nmap <Leader>ahr :Tabularize /=><CR>
-- vmap <Leader>ahr :Tabularize /=><CR>
--

-- vim.keymap.set('n', '<leader>c', 'ZZ')
-- vim.keymap.set('n', '<leader>e', ':edit<SPACE>')

--
-- " buffer nav
-- nmap <Leader>b :Buffers<CR>
-- nmap <Leader>1 :1b<CR>
-- nmap <Leader>2 :2b<CR>
-- nmap <Leader>3 :3b<CR>
-- nmap <Leader>4 :4b<CR>
-- nmap <Leader>5 :5b<CR>
-- nmap <Leader>6 :6b<CR>
-- nmap <Leader>7 :7b<CR>
-- nmap <Leader>8 :8b<CR>
-- nmap <Leader>9 :9b<CR>
-- nmap <Leader>0 :10b<CR>
-- nmap <Leader>vs :vsplit<CR>
-- nmap <Leader>fh :%s/:\(\w\+\)\s*=>\s*/\1: /g<CR>
-- nmap <Leader>k :bnext<CR>
-- nmap <Leader>j :bprevious<CR>
-- nmap <Leader>h :bfirst<CR>
--
-- vnoremap <C-j> :m '>+1<CR>gv=gv
-- vnoremap <C-k> :m '<-2<CR>gv=gv
-- vnoremap <C-l> :><CR>gv=gv
-- vnoremap <C-h> :<<CR>gv=gv
--
-- "copy visual selection to clipboard
-- vnoremap <C-c> "*y<CR>
--
-- " Git grep visually selected text
-- vnoremap <Leader>ag y:Ag '<c-r>"' *<cr>
--
--
-- " quickly edit and source vimrc
-- nnoremap <Leader>vrce :vsplit $MYVIMRC<cr>
-- nnoremap <Leader>vrcs :source $MYVIMRC<cr>
