"""
" General
"
set autoread
set history=666
set lazyredraw

"""
" UI
"
set visualbell
" This solves the issue of freezing/hanging when scrolling out of bounds
" http://superuser.com/questions/667121/
set noeb vb t_vb=
"
" Search
set ignorecase
" With ignorecase & smartcase both enabled, if there is one upper char, will assume case-sensitive search
set smartcase
set hlsearch
" incsearch - start searching when you type the first character of the search string
set incsearch
"
"  Wildmenu
set wildmenu
set wildignore=*.o,*~,*.pyc

"""
" Syntax / formatting
"
" Indentation
filetype indent plugin on
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
" tab -> spaces
set expandtab
" Enable syntax highlighting
syntax on
" No auto newline
:set wrap linebreak nolist
set formatoptions=l

"""
" Appearance
"
colorscheme darkblue
set cmdheight=4
set relativenumber
:set numberwidth=5
" Auto line number
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
:au FocusLost * :set number
:au FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
" Number toggle
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
"
nnoremap <C-n> :call NumberToggle()<cr>
"
set ruler

"""
" Shortcuts
"
" Move Line Up/Down
" Equivalent to Xcode `Alt-Cmd-[` `Alt-Cmd-]`
nnoremap ,<Up>   :<C-u>silent! move-2<CR>==
nnoremap ,<Down> :<C-u>silent! move+<CR>==
xnoremap ,<Up>   :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap ,<Down> :<C-u>silent! '<,'>move'>+<CR>gv=gv
" Look for merge conflicts
nnoremap ,w :/<<<<<<<<CR>
nnoremap ,t :/=======<CR>
nnoremap ,c :/>>>>>>><CR>

