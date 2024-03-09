" ----------------------------
" ----- General settings -----
" ----------------------------

" Re-map leader key
nnoremap <space> <nop>
let mapleader=' '

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
lang en_US.UTF-8

" Enable type file detection
filetype on
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax enable

" Add numbers to each line on the left-hand side.
set number
set ruler

" Set default indentation
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set shiftround

" Do not save temporary files.
set nobackup
set noswapfile

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10
set splitbelow

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap
set nocp

" Searching
set incsearch
set hlsearch
set matchpairs+=<:>
set ignorecase
set smartcase

" Enable mouse interaction
set ma
set mouse=a

" Show several useful info
set showcmd
set noshowmode
set showmatch

" Get rid of scratch buffer
set completeopt-=preview

" Enable auto completion menu after pressing TAB.
set wildmenu
set wildmode=list:longest

" Set the commands to save in history default number is 20.
set history=1000

" -----------------------------
" ----- Plugin definition -----
" -----------------------------

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Colorscheme
Plug 'rose-pine/vim'

" Fzf vim integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Parentheses, brackets, quotes, tags, and more
Plug 'tpope/vim-surround'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Shows git diff markers in the sign column
Plug 'airblade/vim-gitgutter'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" --------------
" ----- UI -----
" --------------

" Colorscheme
" autocmd VimEnter * hi Normal ctermbg=none
set background=dark
let g:disable_bg = 1
let g:disable_float_bg = 1
colorscheme rosepine

" Custom statusline
set laststatus=2
set statusline=
set statusline+=%2*
set statusline+=%=
set statusline+=%f
set statusline+=\ 
set statusline+=%2*
set statusline+=%m
set statusline+=\ 
set statusline+=%3*
set statusline+=%y
set statusline+=\ 
set statusline+=%4*
set statusline+=%{strlen(&fenc)?&fenc:'none'}
set statusline+=\|
set statusline+=%l
set statusline+=:
set statusline+=%L
set statusline+=\ 
set statusline+=%2*
set statusline+=\ 
set statusline+=%1*
set statusline+=%{StatuslineMode()}
set statusline+=\ 

" Custom statusline segment color
hi User1 ctermbg=NONE ctermfg=lightgreen guibg=NONE guifg=lightgreen
hi User2 ctermbg=NONE ctermfg=lightcyan guibg=NONE guifg=lightcyan
hi User3 ctermbg=NONE ctermfg=lightyellow guibg=NONE guifg=lightyellow
hi User4 ctermbg=NONE ctermfg=grey guibg=NONE guifg=grey

" Get current mode
function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#'n'
    return 'NORMAL'
  elseif l:mode==?'v'
    return 'VISUAL'
  elseif l:mode==#'i'
    return 'INSERT'
  elseif l:mode==#'R'
    return 'REPLACE'
  elseif l:mode==?'s'
    return 'SELECT'
  elseif l:mode==#'t'
    return 'TERMINAL'
  elseif l:mode==#'c'
    return 'COMMAND'
  elseif l:mode==#'!'
    return 'SHELL'
  endif
endfunction

" -------------------
" ----- Mapping -----
" -------------------

" Remap insert mode escape key
inoremap jk <esc>

" Remap c-w prefix
nnoremap <silent> <leader>w <c-w>

" Remap switch region keys
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

" Re-size split windows using arrow keys
nnoremap <silent> <up> :resize -2<cr>
nnoremap <silent> <down> :resize +2<cr>
nnoremap <silent> <left> :vertical resize +2<cr>
nnoremap <silent> <right> :vertical resize -2<cr>

" Remap indent keys
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" Search current marked text
vnoremap <leader>/ y/\V<c-r>=escape(@",'/\')<cr><cr>

" Turn off highlight
nnoremap <silent> \| :noh<cr>

" Copy marked text/paste to/from global register
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" Open git client
nnoremap <leader>G :!lazygit<cr><cr>

" ---------------------
" ----- Utilities -----
" ---------------------

" Terminal
autocmd TerminalOpen * setlocal nonumber

" Netrw config and mapping
hi! link netrwMarkFile Search

" Toggle netrw and focus file
nnoremap <leader>e :Explore<cr>
nnoremap <leader>E :Explore %:p:h<cr>

" Remap key inside netrw buffer
function! NetrwMapping()
  " cancel browsing
  nmap <buffer> <silent> x :Rexplore<cr>
  " go back in history
  nmap <buffer> <silent> H u
  " go up a dir
  nmap <buffer> <silent> h -^
  " open a dir or file
  nmap <buffer> <silent> l <cr>
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

" ---------------------------------
" ----- Plugin configuration ------
" ---------------------------------

" Fzf config
let g:fzf_vim={}
let g:fzf_vim.preview_window=[]
let g:fzf_layout={ 'window': { 'width': 0.6, 'height': 0.6 } }

" Fzf mapping
nnoremap <leader>f :GFiles<cr>
nnoremap <leader>F :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>/ :Rg<cr>

" Don't let GitGutter set sign backgrounds
let g:gitgutter_set_sign_backgrounds=1
highlight SignColumn ctermbg=none
