"""
" Plugins
"
" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" 
"
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'csapprox'
"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

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
"
" Tell vim to remember certain things when we exit
" Taken from
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
"
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
"

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

