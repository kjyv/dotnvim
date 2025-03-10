set nocompatible            " disable compatibility to old-time vi
set tabstop=4
set shiftwidth=4
set expandtab
set showmatch               " show matching
set ignorecase              " case insensitive
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set number                  " add line numbers
set relativenumber
set autoindent
set hlsearch
set incsearch
set smarttab
set wildmode=longest,list   " get bash-like tab completions

filetype plugin indent on   "allow auto-indenting depending on file type
syntax on
filetype plugin on

"vim modeline are insecure, but can be useful
"set modeline
"set modelines=1

set tw=100  "line break width, use gqgq to break lines automatically
set wrap nolist
set formatoptions=croql "tcq

"always use black hole register to delete (cut and paste still as normal)
"http://vim.wikia.com/wiki/Replace_a_word_with_yanked_text
noremap d "_d
noremap dd "_dd
noremap D "_D
noremap c "_c

" paste without yanking
vnoremap p "_dP

set backspace=2

" center the screen after jumping
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap # #zzzv
nnoremap * *zzzv

" center after half screen jump
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
