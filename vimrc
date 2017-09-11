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
" Size of an indent measured in spaces
" Needs to equal tabstop, value is also used by '<' and '>'
set shiftwidth=4
" Insert spaces when tab is used to ensure consistency between editors
set expandtab
"Force linewrap after the 79th char
"set tw=79
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

" Get current file type and name
" Select interpreter based on file type and build the exec command
" https://stackoverflow.com/a/30341535
function! ExecByFiletype()
    " List of commonly used language and their interpreters
    let formatFiletype = {
    \   'javascript': 'node',
    \   'python': 'python',
    \   'sh': 'bash'
    \ }
    " Get matching interpreter based on filetype (e.g 'python')
    let scripFiletype = get(formatFiletype, &filetype, &filetype)
    " Get file name (e.g 'file.py')
    let scriptName = expand("%")
    " Build the command and exec (e.g ':!python file.py')
    exe '!' . scripfileType scriptName
endfunction

" Execute current script
map <C-p> :call ExecByFiletype()<CR>
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

" Highlight trailing whitespaces and blank lines with unwanted spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
