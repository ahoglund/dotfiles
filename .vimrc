if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
" Plug 'scrooloose/nerdtree'
" Plug 'wincent/command-t'
Plug 'ElmCast/elm-vim'
Plug 'keith/rspec.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'elixir-lang/vim-elixir'
Plug 'vim-ruby/vim-ruby'
Plug 'janko-m/vim-test'
Plug 'bswinnerton/vim-test-github'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'neomake/neomake'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rakr/vim-one'
Plug 'jpo/vim-railscasts-theme'
Plug 'kassio/neoterm'
" Plug 'fatih/vim-go'
Plug 'leafgarland/typescript-vim'
Plug 'digitaltoad/vim-pug'
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

" colorscheme one
colorscheme railscasts
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

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+2

set list listchars=tab:»·,trail:·,nbsp:·

" Set status line with current branch (from vim.fugitive)
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" leader key remapped to spacebar
let mapleader=","
map <space> <leader>

" Fuzzy Finder
" Use GFiles so that .gitignore'd files dont show
" nmap <silent> <leader>r :GFiles<CR>
nmap <silent> <Leader>r :Files<CR>

" Touchbar!
inoremap jj <esc>
inoremap jk <esc>

" vim-test
nmap <Leader>t :TestNearest<CR>
nmap <Leader>T :TestFile<CR>
nmap <Leader>a :TestSuite<CR>
nmap <Leader>l :TestLast<CR>
nmap <Leader>g :TestVisit<CR>

let test#runners = {'Ruby': ['GitHub']}

if has("nvim")
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let test#strategy = "neovim"
  tnoremap <Esc> <C-\><C-n>
  let g:neoterm_default_mod = 'verbose'
  let g:test#preserve_screen = 1
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

nmap <silent> <Leader>s :!<CR>
nmap <Leader>f /<C-R><C-W><CR>
nmap <Leader>c ZZ<CR>
nmap <Leader>w :w!<CR>

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

let g:rails_projections = {
\  "test/models/api/*_test.rb": {
\    "alternate": "app/api/{}.rb",
\    "type": "api"
\  },
\  "app/api/*.rb": {
\    "alternate": "test/integration/api/{}_test.rb",
\    "type": "api"
\  },
\  "app/api/schemas/v3/schemas/*.json": {
\    "type": "jsonschema"
\  },
\  "app/api/serializer/*_dependency.rb": {
\    "type": "serializer"
\  },
\  "app/controllers/*_controller_methods.rb": {
\    "alternate": "test/controllers/{}_test.rb",
\    "type": "controller_methods"
\  },
\  "test/integration/api/*_test.rb": {
\    "alternate": "app/api/{}.rb",
\    "type": "api-test"
\  },
\  "jobs/*.rb": {
\    "alternate": "test/jobs/{}_test.rb",
\    "type": "job"
\  },
\  "test/jobs/*_test.rb": {
\    "alternate": "jobs/{}.rb",
\    "type": "test"
\  },
\  "docs/*": {
\    "type": "doc"
\  },
\  "app/view_models/*_view.rb": {
\    "alternate": "test/view_models/{}_view_test.rb",
\    "type": "view-model"
\  },
\  "test/view_models/{}_view_test.rb": {
\    "alternate": "app/view_models/{}_view.rb",
\    "type": "test"
\  },
\  "lib/github/transitions/*.rb": {
\    "alternate": "test/lib/github/transitions/{}_test.rb",
\    "type": "transition"
\  },
\  "test/lib/github/transitions/*_test.rb": {
\    "alternate": "lib/github/transitions/{}.rb",
\    "type": "transition-test"
\  },
\  "lib/platform/objects/*.rb": {
\    "alternate": "test/lib/platform/integration/objects/{}_test.rb",
\    "type": "object"
\  },
\  "lib/platform/mutations/*.rb": {
\    "alternate": "test/lib/platform/integration/mutations/{}_test.rb",
\    "type": "mutation"
\  },
\  "test/rubocop/cop/*.rb": {
\    "alternate": "test/rubocop/tests/{}_test.rb",
\    "type": "cop"
\  },
\  "app/api/access_control/*_dependency.rb": {
\    "type": "access-control"
\  }
\}

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
