if !has('nvim')
    set encoding=utf-8
endif

if has('gui_macvim') || exists("g:neovide")
    set guifont=Monaco\ for\ Powerline:h13
    let g:neovide_input_macos_option_key_is_meta = 'only_left'
    let g:neovide_cursor_animation_length = 0
    let g:neovide_cursor_animate_in_insert_mode = 0
    let g:neovide_refresh_rate = 1000

    "imap <D-v> 
    lua vim.keymap.set( {'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'}, '<D-v>', function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end, { noremap = true, silent = true })
endif

set breakindent
set hidden
set smartcase

" rebind shift-motions to text selection (prevent accidental page jumping)
imap <S-Up> <Up>
imap <S-Down> <Down>
imap <S-Left> <Left>
imap <S-Right> <Right>
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>

" show some whitespace characters
set list                  " show line-endings, tabs and trailing spaces
set lcs=trail:·,tab:»·    " trailing spaces and tabs are shown but not eol

" show all whitespace
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" set list

"set mouse mode in terminal
" set mouse=v
set guicursor+=a:blinkon0

" jumping to searches with some spacing from top/bottom
" set scrolloff=5

" navigate jumplist with alt-left/-right
"nnoremap <M-Left> <C-O>
"nnoremap <M-Right> <C-i>

" navigate changelist with alt-left/-right
" nnoremap <M-Left> g;
" nnoremap <M-Right> g,

set showmatch    " show matching braces
set nofoldenable " no folds by default

if has("gui_running")
  " 2 use non backracking regexp engine (faster)
  " 1 use old engine (faster for eg easytags?)
  set regexpengine=2

  set mouse=a

  " no toolbar
  set guioptions-=T

  "save with ctrl-s
  nnoremap <silent> <C-S> :<C-u>Update<CR>
  inoremap <c-s> <c-o>:Update<CR>

  "gui tabs
  source $HOME/.vim/tabs.vim
  noremap <c-tab> :tabnext<cr>
  noremap <c-s-tab> :tabprev<cr>

  "set showtabline=2 " always show tabbar, fixes resizing issues
else
  "some terminal speed-ups
  "set nocursorline
  "set lazyredraw
  set nocursorcolumn
  set ttimeoutlen=10
endif
