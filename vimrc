"
"" Plugin manager
"

" Required to use Vundle
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"
"" Plugin list
"

Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'crusoexia/vim-monokai'

call vundle#end()

"
"" Plugin settings
"

" Airline theme
let g:airline_theme='powerlineish'

" Display all buffers on top
let g:airline#extensions#tabline#enabled = 1

" Customize the filename section (readonly flag, full path to the file)
let g:airline_section_c = airline#section#create(['%r', '%m', '%f'])

" This section normally shows filtetype but we disable it as we already
" display the same info on the next section
let g:airline_section_x = ''

" Customize the file encoding section (fileformat, encoding, filetype)
let g:airline_section_y = airline#section#create(['%{&fileformat}', ' | ', '%{&fenc}', ' | ', '%{strlen(&ft) ? &ft : "unknown"}'])

" Customize current position in file (percentage, line N, virtualcolumn N)
let g:airline_section_z = airline#section#create(['%3p%%', ' | ', 'LN', '%3l',':','%-3v'])

" Set default folder for NerdTree
" autocmd VimEnter * NERDTree ~/Path/to/Project

"
"" General
"

" Disable swap file generation
set noswapfile

" Enable backspace normal behavior
set backspace=indent,eol,start

" Enable filetype detection
filetype plugin indent on

"
"" Colors
"

" Set default colorscheme (see .vim/colors)
colorscheme monokai

" This method allows to override some colors of the selected colorscheme
" https://stackoverflow.com/a/7383051

" Mode message (e.g. '-- Insert --')
autocmd ColorScheme * highlight ModeMsg ctermfg=white
" Background
autocmd ColorScheme * highlight Normal ctermfg=231 ctermbg=235
" Delimiter (vertical bar to show max char limit)
autocmd ColorScheme * highlight ColorColumn ctermbg=236
" Tab bar
autocmd ColorScheme * highlight TabLineFill term=bold cterm=bold ctermbg=8
" Inactive Tab
autocmd ColorScheme * highlight TabLine cterm=bold ctermfg=LightGrey ctermbg=DarkGrey
" Active Tab
autocmd ColorScheme * highlight TablineSel cterm=bold ctermfg=Green ctermbg=Black
" Delimiter (NERDTree and split pane)
autocmd ColorScheme * highlight VertSplit ctermfg=darkgrey ctermbg=None
" NERDTree Folder
autocmd ColorScheme * highlight NERDTreeDir ctermfg=141
" Slash that appears on the right of the folder name
autocmd ColorScheme * highlight NERDTreeDirSlash ctermfg=141
" Folder arrow (not opened)
autocmd ColorScheme * highlight NERDTreeOpenable ctermfg=81
" Folder arrow (opened)
autocmd ColorScheme * highlight NERDTreeClosable ctermfg=81


"
"" Ergonomy
"

" Activate syntax higlighting
syntax on

" Highlight search results
set hlsearch
" Hightlight search results while typing
set incsearch
" Update window title
set title
" Display cursor position
set ruler
" Show line numbers
set number

" Activate mouse control
set mouse=a

" Add a vertical bar to show the 80 char limit
set colorcolumn=80

" Status bar always enabled
set laststatus=2

"
"" Formatting options
"

"Force a linewrap after the 79th char
"set tw=79

" Insert spaces when <Tab> is used
set expandtab
" Length of a tabulation (in spaces)
set tabstop=4
" Size of an indent (in spaces)
" Needs to equal tabstop, value is also used by '<' and '>'
set shiftwidth=4

" Set tabs with a width of 2 characters for html files
autocmd FileType html setlocal shiftwidth=2 tabstop=2

" Autoformat paragraphs when editing markdown files
" This will also hard wrap each line after the 80th char
autocmd FileType md,markdown setlocal formatoptions+=a

"
"" Key mapping
"

" Select interpreter based on file type and exec file
map <C-p> :call ExecByFiletype()<CR>

" Remap Esc for ;; (press it twice)
imap ;; <Esc>
map ;; <Esc>

" Bind Ctrl + z to save
nnoremap <C-z> :w<CR>

" Bind Ctrl + n to toggle NerdTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Ctrl + left arrow to switch to prev buffer
nnoremap <C-left> :bprev<CR>

" Ctrl + right arrow to switch to next buffer
nnoremap <C-right> :bnext<CR>

"
"" Utilities
"

" A convenient way to exec all sorts of scripts (complete the list below)
" Also works with user inputs (tested with python 'raw_input')
" https://stackoverflow.com/a/30341535
function! ExecByFiletype()
    " List of commonly used languages and their interpreters
    let getInterpreter = {
    \   'javascript': 'node',
    \   'python': 'python',
    \   'sh': 'bash'
    \ }
    " Get matching interpreter based on filetype (e.g 'python')
    let scriptType = get(getInterpreter, &filetype, &filetype)
    " Get file name (e.g 'file.py')
    let scriptName = expand("%")
    " Build the command and exec (e.g ':!python file.py')
    " Clear the screen first for better readability
    exe '!clear;' . scriptType scriptName
endfunction

" Highlight trailing whitespaces and blank lines with unwanted spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
