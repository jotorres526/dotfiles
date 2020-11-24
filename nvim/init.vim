"############### PLUGINS ###############

" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif


call plug#begin('~/.config/nvim/plugged')

" Nerd tree to see file structure
Plug 'preservim/nerdtree', {'NERDTreeChDirMode': '2'}
" Better info display
Plug 'itchyny/lightline.vim'
" lightline and ale integration
Plug 'maximbaz/lightline-ale'
" Cute icons uwu
Plug 'ryanoasis/vim-devicons'
" Cute startup screen
Plug 'mhinz/vim-startify'
" See ident lines
Plug 'Yggdroot/indentLine'
" Auto close brackets
Plug 'Raimondi/delimitMate'
" Show git diff in sign column
Plug 'airblade/vim-gitgutter'

" Ale
let g:ale_completion_enabled = 1 
let g:ale_completion_autoimport = 1
" let g:ale_lint_delay =      " for laptop battery preservation

" Syntax highlighting and completion
Plug 'dense-analysis/ale'
" Aligning text
Plug 'godlygeek/tabular'


call plug#end()

"############### COLOR #################
set termguicolors


" Italic comments
hi Comment cterm=italic gui=italic

" Set a syntax for some extenstions
au BufReadPost *.opml setlocal syntax=xml | setlocal filetype=xml
au BufReadPost *.rasi setlocal syntax=css | setlocal filetype=css
au BufReadPost *.vue setlocal syntax=html

"############### IDENTATION #################

set tabstop=4               " Number of visual spaces per Tab
set softtabstop=4           " Number of spaces in tab when editing
set shiftwidth=4            " Number of spaces to use for autoindent
set expandtab               " Tabs are spaces
set copyindent              " Copy the indentation from the previous line
set autoindent              " Automatically indent new lines

"############### SEARCH #################

set incsearch               " Search as characters are typed
set hlsearch                " Highlight matches
set ignorecase              " Ignore case when searching
set smartcase               " Ignore case when only lower case is typed

"############### KEYBINDINGS ###############
" Ctrl+f -> Toggle Tree view
map <C-f> :NERDTreeToggle<CR>


" Ctrl+[Left | Right] -> tabs navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Ctrl+Up -> open new tab
nnoremap <C-Up> :tabnew <right><CR>

" Ctrl+Down -> close the current tab (can't close the last one)
nnoremap <C-Down> :tabclose<CR>

" F2 -> Replaces TABs with spaces
nnoremap <F2> :retab <CR> :w! <CR>

" F3 -> Toggle the coloring of the 80th column
nnoremap <F3> :call ToggleCC()<CR>

"################# OTHER SETTINGS #################
set number                  " Line numbers
set rnu                     " Display line number relative to the current one
set backspace=indent,eol,start " Fix backspace indent
set cursorline              " Highlight the current line
set showmatch               " Highlight matching brackets
set scrolloff=3             " Minimum lines to keep above/below cursor
set autochdir               " Always on the buffer directory
set linebreak	            " Break lines at word (requires Wrap lines)
set showbreak=+++
set signcolumn=yes          " Always show sign column
"################# COMMANDS #################
" Toggles the coloring of the 80th column
function! ToggleCC()
    if &cc == ''
        set cc=80
        echomsg '80th column color: on'
    else
        set cc=
        echomsg '80th column color: off'
    endif
endfunction

"################# AUTO COMMANDS #################
" Delete trailing whitespaces on save
autocmd BufRead,BufNewFile * %s/\s\+$//e

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"############### PLUGIN CONFIG ###############################
" Automatically close NERDTree if it's the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:lightline = {
\ 'colorscheme': 'seoul256',
\ 'active': {
\   'left' : [ [ 'mode', 'paste' ], 
\              [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
\   'right': [ [ 'lineinfo' ],
\              [ 'percent' ],
\              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ],
\              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ] ]
\ },
\ 'component_function': {
\   'gitbranch': 'gitbranch#name'
\ },
\ }

let g:lightline.component_expand = {
\ 'linter_checking': 'lightline#ale#checking',
\ 'linter_infos': 'lightline#ale#infos',
\ 'linter_warnings': 'lightline#ale#warnings',
\ 'linter_errors': 'lightline#ale#errors',
\ 'linter_ok': 'lightline#ale#ok',
\ }
let g:lightline.component_type = {
\ 'linter_checking': 'right',
\ 'linter_infos': 'right',
\ 'linter_warnings': 'warning',
\ 'linter_errors': 'error',
\ 'linter_ok': 'right',
\ }

" ### ALE ###
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'haskell': ['hls'],
\ 'java' : ['javac'],
\ }

