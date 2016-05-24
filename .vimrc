execute pathogen#infect()
" syntax on
" filetype plugin indent on
" colorscheme molokai            "vim color scheme

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" strip whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

nmap <C-n> :NERDTreeToggle<CR>
vmap <C-n> :NERDTreeToggle<CR>

" set backspace=indent,eol,start "allow backspacing over everything in insert mode
set cursorline                 "highlight current line
set history=50                 "keep 50 lines of command line history
set hlsearch                   "highlight matches when searching
set incsearch                  "do incremental searching
set number                     "show line numbers
set ruler                      "show the cursor position all the time
set showcmd                    "display incomplete commands
set wildmenu                   "visual autocomplete for command menu

" setup tabbing
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>''<SPACE>*

if exists(".Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
end

let mapleader=" "
" multiple cursor remap
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-b>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" easier split pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright
