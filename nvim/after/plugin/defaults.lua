local map = require("utils").map
local imap = require("utils").imap
local vmap = require("utils").vmap

map('n', '<leader>sb', ':w!<CR>')
map('n', '<leader>w', ':w!<CR>')
map('n', '<leader>c', 'ZZ<CR>')
-- map('n', '<leader>cb', 'ZZ<CR>')
-- map('n', '<leader>e', ":e <C-R>=expand('%:p:h') . '/'<cr>")
map('n', '<leader>e', ':edit<SPACE>')
map('n', '<leader>vr', "<cmd>lua ReloadConfig()<CR>")
map('n', '<leader>t', ':TestNearest<CR>')
map('n', '<leader>T', ':TestFile<CR>')
map('n', '<leader>a', ':TestSuite<CR>')
map('n', '<leader>l', ':TestLast<CR>')
map('n', '<leader>g', ':TestVisit<CR>')
map('n', '<leader>f', '/<C-R><C-W><CR>')
map('n', '<leader>vs', ':vsplit<CR>')
-- " Git grep visually selected text
vmap('<C-g>', '')

-- vim.g.copilot_no_tab_map = 1
-- imap('<silent><script><expr> <C-J>', 'copilot#Accept("<C-R>=expand("%:p:h") . "/"<CR>")')

vim.cmd('noremap <C-b> :noh<cr>:call clearmatches()<cr>') -- clear matches Ctrl+b

-- function Mkdir()
--   local dir = vim.expand('%:p:h')
--
--   if vim.fn.isdirectory(dir) == 0 then
--     vim.fn.mkdir(dir, 'p')
--     print('Created directory: ' .. dir)
--   end
-- end
--
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   command = 'lua Mkdir()',
--   pattern = '*',
-- })
--
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
-- nnoremap <leader>y :call system('socat - UNIX-CLIENT:$HOME/.clipper.sock', @0)<CR>

-- nnoremap <Leader>fr :%s/\<<C-r><C-w>\>/
-- vnoremap <Leader>fr "hy:%s/<C-r>h/
--
-- inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
-- inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
-- inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
--
-- nmap <Leader>ae :Tabularize /=<CR>
-- vmap <Leader>ae :Tabularize /=<CR>
-- nmap <Leader>ah :Tabularize /:\zs<CR>
-- vmap <Leader>ah :Tabularize /:\zs<CR>
-- nmap <Leader>ahr :Tabularize /=><CR>
-- vmap <Leader>ahr :Tabularize /=><CR>
--


--
-- " buffer nav
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
--
--
-- " quickly edit and source vimrc
-- nnoremap <Leader>vrce :vsplit $MYVIMRC<cr>
-- nnoremap <Leader>vrcs :source $MYVIMRC<cr>
