" Just in case, for vimwiki
set nocompatible
filetype plugin on
syntax on

call plug#begin('~/.vim/bundle')
" Tabular, for lining up things
Plug 'godlygeek/tabular'
" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
" Plug 'jeffkreeftmeijer/neovim-sensible'
" Add ends to certain blocks in various langs
Plug 'tpope/vim-endwise'
" allow for commenting
Plug 'tpope/vim-commentary'
" GitHub
Plug 'tpope/vim-rhubarb'
" change things that surround things
Plug 'tpope/vim-surround'
Plug 'elixir-lang/vim-elixir'
Plug 'vim-ruby/vim-ruby'
Plug 'janko-m/vim-test'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
" Linting, Compiling and stuff
Plug 'neomake/neomake'
" Finding stuff, faster
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Theme
" Plug 'jpo/vim-railscasts-theme'
Plug 'kassio/neoterm'
Plug 'leafgarland/typescript-vim'
Plug 'digitaltoad/vim-pug'
Plug 'vimwiki/vimwiki'
Plug 'fatih/vim-go'
" LSP
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

" I actually have nvim 0.4.3 installed, but since native
" macOS vim is not greater than 8 something i need to add this
" to silence vim-go warnings:
let g:go_version_warning = 0

call plug#end()

" strip whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
" convert tabs on save
autocmd BufWritePre *.rb :%s/\t\+/  /e
" convert tabs on save
autocmd BufWritePre *.java :%s/\t\+/  /e
" mkdir if file doesn't exist
autocmd BufWritePre * call s:Mkdir()

call neomake#configure#automake('w')

" set virtualedit=all
set background=dark
" Showcase comments in italics

highlight Comment cterm=italic gui=italic

" faster syntax highlighting
set re=1

set cursorline  "highlight current line
set history=50  "keep 50 lines of command line history
set hlsearch    "highlight matches when searching
set incsearch   "do incremental searching
set number      "show line numbers
set numberwidth=5
set showcmd     "display incomplete commands
"set paste

"folding settings
set foldmethod=indent "fold based on indent
set foldnestmax=10    "deepest fold is 10 levels
set nofoldenable      "dont fold by default
set foldlevel=1       "this is just what i use

" setup tabbing
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Make it obvious where 148 characters is
set textwidth=148
set colorcolumn=+2

set list listchars=tab:»·,trail:·,nbsp:·

" Set status line with current branch (from vim.fugitive)
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" leader key remapped to spacebar
let mapleader=","
map <space> <Leader>


" Touchbar!
inoremap jj <esc>
inoremap jk <esc>

" vim-test
nmap <Leader>t :TestNearest<CR>
nmap <Leader>T :TestFile<CR>
nmap <Leader>a :TestSuite<CR>
nmap <Leader>l :TestLast<CR>
nmap <Leader>g :TestVisit<CR>
nnoremap <leader>y :call system('nc -U ~/.clipper.sock', @0)<CR>

nmap <Leader>f /<C-R><C-W><CR>
nnoremap <Leader>fr :%s/\<<C-r><C-w>\>/
vnoremap <Leader>fr "hy:%s/<C-r>h/

if has("nvim")
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let test#strategy = "neovim"
  tnoremap <Esc> <C-\><C-n>
  let g:neoterm_default_mod = 'vertical'
  let g:test#preserve_screen = 1
endif

nnoremap <C-p> :Files<CR>
nmap <silent> <Leader>r :Files<CR>
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  let g:ctrlp_use_caching = 0
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
endif

nmap \ :Rg<SPACE>
nmap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

nmap <Leader>ae :Tabularize /=<CR>
vmap <Leader>ae :Tabularize /=<CR>
nmap <Leader>ah :Tabularize /:\zs<CR>
vmap <Leader>ah :Tabularize /:\zs<CR>
nmap <Leader>ahr :Tabularize /=><CR>
vmap <Leader>ahr :Tabularize /=><CR>

nmap <Leader>c ZZ<CR>
nmap <Leader>s :w!<CR>

" buffer nav
nmap <Leader>b :Buffers<CR>
nmap <Leader>1 :1b<CR>
nmap <Leader>2 :2b<CR>
nmap <Leader>3 :3b<CR>
nmap <Leader>4 :4b<CR>
nmap <Leader>5 :5b<CR>
nmap <Leader>6 :6b<CR>
nmap <Leader>7 :7b<CR>
nmap <Leader>8 :8b<CR>
nmap <Leader>9 :9b<CR>
nmap <Leader>0 :10b<CR>
nmap <Leader>e :edit<SPACE>
nmap <Leader>v :view<SPACE>
nmap <Leader>fh :%s/:\(\w\+\)\s*=>\s*/\1: /g<CR>
nmap <space><space> <C-^><CR>
nmap <Leader>k :bnext<CR>
nmap <Leader>j :bprevious<CR>
nmap <Leader>h :bfirst<CR>

vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <C-l> :><CR>gv=gv
vnoremap <C-h> :<<CR>gv=gv

"copy visual selection to clipboard
vnoremap <C-c> "*y<CR>

" Git grep visually selected text
vnoremap <Leader>ag y:Ag '<c-r>"' *<cr>

" easier split pane navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>
set splitbelow
set splitright

" functions

function s:Mkdir()
  let dir = expand('%:p:h')

  if !isdirectory(dir)
    call mkdir(dir, 'p')
    echo 'Created non-existing directory: '.dir
  endif
endfunction

function! OpenPR(sha)
  let pr_number = system("git log --merges --ancestry-path --oneline ". a:sha . "..master | grep 'pull request' | tail -n1 | awk '{print $5}' | cut -c2-")
  let remote = fugitive#RemoteUrl(".")
  let root = rhubarb#homepage_for_url(remote)
  let url = root . '/pull/' . substitute(pr_number, '\v\C\n', '', 1)
  call netrw#BrowseX(url, 0)
endfunction

augroup fugitive_ext
  autocmd!
  " Browse to the commit under my cursor
  autocmd FileType fugitiveblame nnoremap <buffer> <localleader>gb :execute ":Gbrowse " . expand("<cword>")<cr>

  " Browse to the PR for commit under my cursor
  autocmd FileType fugitiveblame nnoremap <buffer> <localleader>pr :call OpenPR(expand("<cword>"))<cr>
augroup END

" quickly edit and source vimrc
nnoremap <Leader>vrce :vsplit $MYVIMRC<cr>
nnoremap <Leader>vrcs :source $MYVIMRC<cr>
