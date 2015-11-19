"""
" Syntax
"
filetype indent plugin on
" Enable syntax highlighting
syntax on

"""
" Appearance
"
set guifont=DejaVu\ Sans\ Mono\ 14
colorscheme darkblue
set number

"""
" Shortcuts
"
" Move Line Up/Down
" Equivalent to Xcode `Alt-Cmd-[` `Alt-Cmd-]`
nnoremap ,<Up>   :<C-u>silent! move-2<CR>==
nnoremap ,<Down> :<C-u>silent! move+<CR>==
xnoremap ,<Up>   :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap ,<Down> :<C-u>silent! '<,'>move'>+<CR>gv=gv

