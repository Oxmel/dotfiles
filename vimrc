"" General settings
"
" Switch off Vi compatibility (can cause unexpected Vim behavior when on)
set nocompatible
" Update window title
set title
" Display cursor position
set ruler
" Highlight search results
set hlsearch
" Hightlight search results while typing
set incsearch
" Show line numbers
set number
" Enable backspace normal behavior
set backspace=indent,eol,start
" Disable swap file generation
set noswapfile
" Enable filetype detection
filetype on
filetype plugin on
filetype indent on
"
"" Theme and ergonomy
"
" Enable 256 colors
"set t_Co=256
" Set monokai as default colorscheme (see .vim/colors)
colorscheme monokai 
" Activate syntax higlighting
syntax on
" Activate mouse control
set mouse=a
" One Tab equals four spaces
set tabstop=4
" Pareil que Tab à revérifier
set shiftwidth=4
"Force linewrap after the 79th char
set tw=79
" Add a vertical bar to show the 80 char limit 
set colorcolumn=80
" Call plugin agent and agent helper
execute pathogen#infect()
call pathogen#helptags()
" Activate vim-airline status bar (replacement of deprecated powerline)
" Status bar always enabled
set laststatus=2
" Bar color
highlight ColorColumn ctermbg=236
" Tab bar color
highlight TabLineFill term=bold cterm=bold ctermbg=8
" Inactive Tab color (foreground, background)
highlight TabLine cterm=bold ctermfg=LightGrey ctermbg=DarkGrey
" Active Tab color
highlight TablineSel cterm=bold ctermfg=Green ctermbg=Black


" Remap Esc for ;; (press it twice)
imap ;; <Esc>
map ;; <Esc>
" Bind Ctrl + a to select all lines
map <C-a> <esc>ggVG<CR>
" Bind Ctrl + z to save
nnoremap <C-z> :w<CR>
" Bind Ctrl + n to toggle NerdTree
nnoremap <C-n> :NERDTreeToggle<CR>
" Setup default folder for NerdTree
" autocmd VimEnter * NERDTree ~/Path/to/Project

" Ctrl + left arrow switch to prev tab 
" (yeah yeah, one file per tab's a bad pratice blah blah blah)
nnoremap <C-left> :tabp<CR>
" Ctrl + right arrow switch to next tab
nnoremap <C-right> :tabn<CR>
