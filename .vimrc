if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'scrooloose/nerdtree'
" Plug 'wincent/command-t'
Plug 'ElmCast/elm-vim'
Plug 'keith/rspec.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'elixir-lang/vim-elixir'
Plug 'vim-ruby/vim-ruby'
Plug 'janko-m/vim-test'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'neomake/neomake'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'rakr/vim-one'
Plug 'kassio/neoterm'
call plug#end()

" strip whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
" convert tabs on save
autocmd BufWritePre *.rb :%s/\t\+/  /e
" mkdir if file doesn't exist
autocmd BufWritePre * call s:Mkdir()

call neomake#configure#automake('w')

set background=dark
colorscheme one

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

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+2

set list listchars=tab:»·,trail:·,nbsp:·

" leader key remapped to spacebar
let mapleader=","
map <space> <leader>

" Fuzzy Finder
nmap <silent> <leader>r :Files<CR>

" Touchbar!
inoremap jj <esc>
inoremap jk <esc>

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

if has("nvim")
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let test#strategy = "neoterm"
  tnoremap <Esc> <C-\><C-n>
  let g:neoterm_default_mod = "vertical"
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nmap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nmap \ :Ag<SPACE>

nmap <Leader>ae :Tabularize /=<CR>
vmap <Leader>ae :Tabularize /=<CR>
nmap <Leader>ah :Tabularize /:\zs<CR>
vmap <Leader>ah :Tabularize /:\zs<CR>
nmap <Leader>ahr :Tabularize /=><CR>
vmap <Leader>ahr :Tabularize /=><CR>

nmap <silent> <leader>s :!<CR>
nmap <leader>f /<C-R><C-W><CR>
nmap <leader>c ZZ<CR>
nmap <leader>w :w!<CR>

" buffer nav
nmap <Leader>b :ls<CR>
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
nmap <leader>e :edit<SPACE>
nmap <leader>v :view<SPACE>
nmap <Leader>fh :%s/:\(\w\+\)\s*=>\s*/\1: /g<CR>
nmap <space><space> <C-^><CR>

vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

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

function! DockerComposeStrategy(cmd)
  execute "T" . ' docker-compose exec test bundle exec spring ' . a:cmd
endfunction

function! LocalSpringStrategy(cmd)
  execute "T" . ' bundle exec spring ' . a:cmd
endfunction

function! GhZeusStrategy(cmd)
  execute "T" . ' bin/tt ' . a:cmd
endfunction

" let g:test#ruby#minitest#executable = 'zeus test'
" let g:test#ruby#rails#executable = 'zeus test'

" let g:test#custom_strategies = {'docker-compose': function('DockerComposeStrategy'), 'gh-zeus': function('GhZeusStrategy')}
" let g:test#strategy = 'gh-zeus'
" let test#ruby#bundle_exec = 0
" let test#ruby#use_binstubs = 1
" let g:test#preserve_screen = 1

" elm
" nnoremap <leader>em :ElmMakeCurrentFile<CR>
" autocmd BufWritePost *.elm ElmMakeCurrentFile

