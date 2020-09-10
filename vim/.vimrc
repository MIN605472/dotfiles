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
Plug 'MIN605472/vim-one'
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'elixir-lang/vim-elixir'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'dart-lang/dart-vim-plugin'
Plug 'vim/killersheep'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
" }}}

" coc {{{
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}

" codefmt setting {{{
call glaive#Install()
Glaive codefmt plugin[mappings]
Glaive codefmt clang_format_style='google'
Glaive codefmt clang_format_executable='clang-format'

" augroup autoformat_settings
"   autocmd FileType bzl AutoFormatBuffer buildifier
"   autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
"   autocmd FileType dart AutoFormatBuffer dartfmt
"   autocmd FileType go AutoFormatBuffer gofmt
"   autocmd FileType gn AutoFormatBuffer gn
"   autocmd FileType html,css,json AutoFormatBuffer js-beautify
"   autocmd FileType java AutoFormatBuffer google-java-format
"   autocmd FileType python AutoFormatBuffer yapf
" augroup END
" }}}

" commentary settings {{{
autocmd FileType c,cpp setlocal commentstring=//\ %s
autocmd FileType cmake setlocal commentstring=#\ %s
" }}}

" airline settings {{{
let g:airline_powerline_fonts = 1
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_theme='one'
" let g:airline#extensions#tabline#enabled = 1
set laststatus=2
" }}}

" theme settings {{{
syntax on
if (has("termguicolors"))
  set termguicolors
endif
set t_Co=256
set background=dark
colorscheme one
set t_8b=[48;2;%lu;%lu;%lum
set t_8f=[38;2;%lu;%lu;%lum
" }}}

" general settings {{{
set nocompatible
filetype plugin indent on
" set number
" set cursorline
" set colorcolumn=80
" set rnu
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set incsearch
set clipboard=unnamed,unnamedplus
set ignorecase
set smartcase
set title
set hlsearch
set showmatch
set wildignore=*.out
set wildmenu
set encoding=utf-8
setglobal fileencoding=utf-8
set equalprg=par
set mouse=h
set noswapfile
set hidden
set cursorline
" }}}

" gui settings {{{
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set backspace=indent,eol,start
if has('unix')
  set guifont=Iosevka\ Term\ 9
elseif has("win32")
  set guifont=Iosevka\ Term:h11
endif
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

" gutentags settings {{{
let g:gutentags_cache_dir = '~/.tags'
" }}}

" mappings {{{
let mapleader = " "
let maplocalleader = "\\"

nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>a :Ag<space>
" let &t_ut=''
" }}}
