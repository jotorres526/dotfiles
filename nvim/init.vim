"############### PLUGINS ###############

" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif



call plug#begin('~/.config/nvim/plugged')

" Nerd tree to see file structure
Plug 'preservim/nerdtree'
" Better info display
Plug 'itchyny/lightline.vim'
" Cute icons uwu
Plug 'ryanoasis/vim-devicons'
" Cute startup screen
Plug 'mhinz/vim-startify'
" See ident lines
Plug 'Yggdroot/indentLine'
" Synthatic sugar
Plug 'tpope/vim-eunuch'


call plug#end()

"############### COLOR #################
set termguicolors

let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ }


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
set cursorline              " Highlight the current line
set showmatch               " Highlight matching brackets
set scrolloff=3             " Minimum lines to keep above/below cursor
set nowrap                  " No wrapping long lines

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

" Automatically close NERDTree if it's the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


