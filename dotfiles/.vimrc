""""
" vimrc file.
"
" Based on the vimrc file by:
"   Bram Moolenaar <Bram@vim.org>
"   Adam Sharp (github: sharplet)

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif


" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible



""""
"""" Plugins
""""

" Vundle
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" Auto Completion
Plugin 'Valloric/YouCompleteMe'
" Plugin 'neocomplcache'

" Version Control
Plugin 'tpope/vim-fugitive'

" Files
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'thoughtbot/pick.vim'

" Editing
Plugin 'airblade/vim-gitgutter'
Plugin 'changesPlugin'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/nerdcommenter'
Plugin 'cohama/lexima.vim'

" Language Specific
Plugin 'Keithbsmiley/swift.vim'
Plugin 'b4winckler/vim-objc'
Plugin 'cfdrake/vim-carthage'
Plugin 'tpope/vim-markdown'
Plugin 'vim-ruby/vim-ruby'
Plugin 'rust-lang/rust.vim'

" Other
Plugin 'L9'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'csapprox'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-dispatch'

call vundle#end()            " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



""""
"""" General
""""

" Enable project-specific .vimrc files
set exrc


" stop unsafe commands running in a .vimrc (http://blog.stwrt.ca/2013/01/23/project-specific-vimrc)
set secure


" automatically load changes in disk if the buffer has not changed
set autoread


" enable hidden buffers
set hidden


" put vim swap files into a shared directory rather than the standard '.%.swp'
" location alongside the file being edited
set directory=~/.vimswap


if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
  set backup            " keep a backup file (restore to previous version)
  set backupdir=~/.vimbackup,.,~/tmp,~/
  set undofile          " keep an undo file (undo changes after closing)
  set undodir=~/.vimundo,.,~/tmp,~/
endif


set history=666         " keep n lines of command line history
set ruler               " show the cursor position all the time
set laststatus=2        " always show the status line
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set ignorecase          " case insensitive searching
set smartcase           " override ignorecase when pattern contains upper case characters
set expandtab           " use spaces instead of tabs by default
set sts=2 ts=2 sw=2     " default indentation
set colorcolumn=80      " n-column page guide
set cursorline          " highlight the current line


set lazyredraw


" invisibles
set list
set listchars+=eol:↵,tab:‣\ ,space:·


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif



""""
"""" Editing
""""

" allow backspacing over everything in insert mode
set backspace=indent,eol,start


" Line wrapping
set nowrap              " disable line wrapping
set sidescroll=5        " minimal number of columns to scroll horizontally
set listchars+=precedes:←,extends:→ " visual indicator of long lines



""""
"""" UI / Appearance
""""

set visualbell


" This solves the issue of freezing/hanging when scrolling out of bounds
" http://superuser.com/questions/667121/
set noeb vb t_vb=


" Search
set ignorecase


" With ignorecase & smartcase both enabled, if there is one upper char, will assume case-sensitive search
set smartcase
set hlsearch


" incsearch - start searching when you type the first character of the search string
set incsearch


" Use an interesting status line, including shortened filenames (like in tabs)
set statusline=%{pathshorten(fnamemodify(expand('%f'),':~:.'))}[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P


" Don't use Ex mode, use Q for formatting
map Q gq


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


set t_Co=256


" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif


if !has("gui_running")
  colorscheme twilight256
endif


" Use posix syntax highlighting for shell scripts unless otherwise specified
let g:is_posix = 1


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


set relativenumber              " relative line numbers
set number                      " current line shows actual number, instead of 0


set splitbelow                  " horizontal splits open below the current window
set splitright                  " vertical splits open to the right of the current window


set cmdheight=4
:set numberwidth=5


"" Mappings

let mapleader=","


"" Selection mode

" Evaluate a selection in-place using <C-R>=
snoremap <C-R><C-R> "-c<C-R>=<C-R>-<CR><Esc>


"" Navigation

" gf will edit a new file if it doesn't exist
map gf :e <cfile><CR>

" Move to the last character on the last line
nmap <C-G> <C-End>


"" Normal mode

" Quickly close windows or buffers
nmap <leader>w :bd<CR>
nmap <leader><leader>w :%bd<CR>
nmap <leader>q :q<CR>
nmap <leader><leader>q :qa<CR>

" Open a tag in a vertical split
nmap <C-\> :vsp<CR>:exec("tag " . expand("<cword>"))<CR>


"" Copy/Paste

" Copy buffer to system clipboard
nnoremap <C-A><C-C> :%y*<CR>

" Copy current selection to system clipboard
vnoremap <C-C> "*y


"" Auto line number

" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
:au FocusLost * :set number
:au FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber


"" Number toggle

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>


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


"" Move Line Up/Down
"" Equivalent to Xcode `Alt-Cmd-[` `Alt-Cmd-]`

nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [e`[V`]
vmap <C-Down> ]e`[V`]


"" Completion

set wildmenu
set wildmode=longest,full
set wildignore=*.o,*~,*.pyc


"" Look for merge conflicts

nnoremap ,w :/<<<<<<<<CR>
nnoremap ,t :/=======<CR>
nnoremap ,c :/>>>>>>><CR>


"" Qargs (http://vimcasts.org/episodes/project-wide-find-and-replace/)

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction


"" grepping

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


"" The Silver Searcher

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " bind \ (backward slash) to grep shortcut
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif



""""
"""" Plugin Settings
""""

"" Git

" switch to the git status buffer in the current window
nmap <leader>s :Gstatus<CR>:only<CR>


"" neocomplcache
" source ~/.vimrc_neocomplcache


"" NERDTree
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


"" ultisnips Snippets
let g:UltiSnipsExpandTrigger="<C-J>"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>"


"" vim-dispatch
let g:dispatch_format='%f:%l: %m,%+I%.%#'
command! -nargs=* -range=0 Todo Dispatch todogrep <q-args>


"" pick.vim
nnoremap <C-P><CR>  :call PickFile()<CR>
nnoremap <C-P><C-T> :call PickFileTab()<CR>
nnoremap <C-P><C-X> :call PickFileSplit()<CR>
nnoremap <C-P><C-V> :call PickFileVerticalSplit()<CR>
nnoremap <C-P><C-B> :call PickBuffer()<CR>


"" NERDCommenter

let g:NERDCustomDelimiters = {
  \ 'ruby': { 'left': '# ' }
\ }



""""
"""" Miscellaneous
""""

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif
