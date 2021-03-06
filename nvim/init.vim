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
" Cute icons uwu
Plug 'ryanoasis/vim-devicons'
" Cute startup screen
Plug 'mhinz/vim-startify'
" Auto close brackets
Plug 'Raimondi/delimitMate'
" Show git diff in sign column
Plug 'airblade/vim-gitgutter'
" Discord goodies cuz why not
Plug 'hugolgst/vimsence'

call plug#end()

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
"set termguicolors

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
" Delete trailing whitespaces
autocmd BufWritePre * %s/\s\+$//e

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"############### PLUGIN CONFIG ###############################
" Automatically close NERDTree if it's the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ### Lightline
let g:lightline = {
\ 'colorscheme': 'seoul256',
\ 'active': {
\   'left' : [ [ 'mode', 'paste' ],
\              [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
\   'right': [ [ 'lineinfo' ],
\              [ 'percent' ],
\              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
\ },
\ 'component_function': {
\   'gitbranch': 'gitbranch#name'
\ },
\ }
