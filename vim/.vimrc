" vim:set fdm=marker:
" plugin manager {{{
if has('unix')
  if has('nvim')
    let s:vim_home = $HOME . '/.local/share/nvim/site'
  else
    let s:vim_home = $HOME . '/.vim'
  endif
  let s:plug_script = s:vim_home . '/autoload/plug.vim'
  if empty(glob(s:plug_script))
    exe 'silent !curl -fLo ' . s:plug_script . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    exe 'source ' . s:plug_script
    au VimEnter * PlugInstall
  endif
endif

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
" Plug 'chriskempson/base16-vim'
" Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'elixir-lang/vim-elixir'
Plug 'mhinz/vim-startify'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/gv.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
" Plug 'w0rp/ale'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-repeat'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'sheerun/vim-polyglot'
" Plug 'ludovicchabant/vim-gutentags'
call plug#end()
" }}}

" codefmt setting {{{
" call maktaba#plugin#Detect()
call glaive#Install()
Glaive codefmt plugin[mappings]
Glaive codefmt clang_format_style='google'
Glaive codefmt clang_format_executable='clang-format'
" }}}

" commentary settings {{{
autocmd FileType c,cpp setlocal commentstring=//\ %s
autocmd FileType cmake setlocal commentstring=#\ %s
" }}}

" airline settings {{{
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ""
let g:airline_right_sep = ""
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
" }}}

" theme settings {{{
syntax on
" if (has("termguicolors"))
"   set termguicolors
" endif
set t_Co=256
colorscheme gruvbox
set background=dark
" }}}

" general settings {{{
set nocompatible
filetype plugin indent on
set nonumber
"set cursorline
"set rnu
set expandtab
set shiftwidth=2
set softtabstop=4
set tabstop=4
set incsearch
set clipboard=unnamed
set ignorecase
set hlsearch
set showmatch
set wildignore=*.out
set wildmenu
set encoding=utf-8
setglobal fileencoding=utf-8
set equalprg=par
set mouse=a
set noswapfile
" }}}

" gui settings {{{
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guifont=Inconsolata:h11
set backspace=indent,eol,start
set guifont=Fantasque\ Sans\ Mono\ 9
" }}}

" netrw settings {{{
let g:netrw_altv = 1
let g:netrw_fastbrowse = 2
let g:netrw_keepdir = 0
let g:netrw_liststyle = 3
let g:netrw_retmap = 1
let g:netrw_silent = 1
let g:netrw_special_syntax = 1
" }}}

" mappings {{{
let mapleader = " "
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <leader>m :AsyncRun make -C build && build/Game<CR>
" }}}
