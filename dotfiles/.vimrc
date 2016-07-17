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
" Auto Completion
Plugin 'Valloric/YouCompleteMe'
" Plugin 'neocomplcache'
" Version Control
Plugin 'tpope/vim-fugitive'
" Files
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'git://git.wincent.com/command-t.git'
" Editing
Plugin 'airblade/vim-gitgutter'
Plugin 'changesPlugin'
Plugin 'git://github.com/tpope/vim-unimpaired.git'
" Other
Plugin 'L9'
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
" Plugin Settings
"
" neocomplcache
" source ~/.vimrc_neocomplcache
"
" NERDTree
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "+",
    \ "Untracked" : "U",
    \ "Renamed"   : "-",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "D",
    \ "Dirty"     : "B",
    \ "Clean"     : "G",
    \ "Unknown"   : "?"
    \ }
" NERDTree toggle hot keys
"

"""
" General
"
set autoread
set history=666
set lazyredraw

"""
" Syntax / formatting
"
"
" Editing

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
" tab -> spaces
set expandtab
" Enable syntax highlighting
syntax on
" No auto newline

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " Set up text width and format options
  autocmd FileType text,markdown        setlocal textwidth=0
  autocmd FileType text,markdown        setlocal autoindent wrap
  autocmd FileType text,markdown        setlocal sts=4 ts=4 sw=4 expandtab
  autocmd FileType c,cpp,objc,objcpp    setlocal textwidth=78
  autocmd FileType c,cpp,objc,objcpp    setlocal formatoptions+=ro
  autocmd FileType c,cpp,objc,objcpp    setlocal comments=b:///,sr:/**,mb:*\ ,ex:*/,b://,sr:/*,mb:*,ex:*/

  " Set up some file types
  autocmd BufRead,BufNewFile *.m set filetype=objc
  autocmd BufRead,BufNewFile PULLREQ_EDITMSG set filetype=gitcommit
  autocmd BufRead,BufNewFile Podfile,*.podspec,Gemfile,Vagrantfile set filetype=ruby

  " Swift files
  autocmd BufRead,BufNewFile *.swift set ts=2 sts=2 sw=2
  autocmd BufRead,BufNewFile *.swift set expandtab
  autocmd BufRead,BufNewFile *.swift set smartindent

  autocmd FileType ruby set ts=2 sts=2 sw=2

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set linebreak                 " when soft wrapping is enabled, break lines at word boundaries
  set breakindent               " when soft wrapping is enabled, keep wrapped lines at same indent level

  set autoindent                " always set autoindenting on

  set expandtab                 " always set expandtab on

endif " has("autocmd")

"""
" Appearance
"
set t_Co=256
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
" Whitespace
:set listchars=eol:↵,tab:>=,trail:~,extends:>,precedes:<,space:·
:set list

"""
" Shortcuts
"
" Move Line Up/Down
" Equivalent to Xcode `Alt-Cmd-[` `Alt-Cmd-]`
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [e`[V`]
vmap <C-Down> ]e`[V`]
" Look for merge conflicts
nnoremap ,w :/<<<<<<<<CR>
nnoremap ,t :/=======<CR>
nnoremap ,c :/>>>>>>><CR>

