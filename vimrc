" vim:et:sw=2:ts=2:ff=unix:fenc=utf8:
"
" Maintainer: Wang Jun
" Last Change: 2018-05-08

set nocompatible

if has('autocmd')
  " Remove ALL autocommands for the current group.
  au!
endif

if filereadable($HOME . '/vimfiles/autoload/plug.vim')
  " vim-plug, see https://github.com/junegunn/vim-plug
  call plug#begin('$HOME/vimfiles/plugged')

  " Make sure you use single quotes

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'aradunovic/perun.vim'
  Plug 'inkarkat/vim-ingo-library'
  Plug 'inkarkat/vim-mark'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'scrooloose/nerdcommenter', { 'for': ['c', 'cpp', 'python'] }
  Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': ['c', 'cpp', 'python'] }
  Plug 'vim-scripts/std_c.zip', { 'for': 'c' }
  Plug 'hdima/python-syntax', { 'for': 'python' }

  " Initialize plugin system
  call plug#end()
endif

" 删除indent自动缩进(行首空白符),eol换行符,start插入模式开始处之前的字符
set backspace=indent,eol,start
" 使移动光标的键在多行之间使用
set whichwrap=b,s,<,>,[,]
" 多字节字符排版:分行,不插入空格
set formatoptions+=mM

" 尝试的字符编码列表
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,latin1
" 设置终端编码,指定键盘输入和显示的字符编码
" TODO: conemu not worked.
let &termencoding = &encoding
"set termencoding=utf-8
" Vim 内部字符编码
set encoding=utf-8
" 把所有的"不明宽度"字符的宽度置为双倍字符宽度(中文字符宽度)
" need 'encoding' is unicode encoding
"set ambiwidth=double " not for powerline fonts.

" vim message language: en_US.UTF-8 , zh_CN.UTF-8
language messages en_US.UTF-8
if has("gui_running")
  " GUI menu language, langmenu=none -> English menu
  set langmenu=en_US.UTF-8
endif

if has("gui_running")
  set go-=T
  set go-=m
  " Windows GUI font settings
  if has("win32")
    set guifont=Iosevka:h13, " Iosevka ss09
          \Courier_New:h12
    " gfw need 'encoding' = utf-8
    set guifontwide=Iosevka:h13,
          \YouYuan:h12
  elseif has("unix")
    set guifont=Iosevka\ 13,
          \DejaVu\ Sans\ Mono\ 12
    set guifontwide=Iosevka\ 13,
          \Noto\ Sans\ Mono\ CJK\ SC\ 12
  endif

  if !exists("g:cols_lines_already_setting")
    set columns=116 lines=32
    " Only set once
    let g:cols_lines_already_setting = &columns
  endif
endif

if has('mouse')
  set mouse=a
endif

" 显示设置
if &t_Co > 2 || has("gui_running")
  if !has("gui_running")
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    " under ConEmu, <BS> may have some problems, like <DEL>.
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>
  endif
  " GUI配色方案设置
  color perun
  set background=dark
  " Vim syntax highlight, will overrule the user's setttings
  syntax on
  " 搜索结果高亮
  set hlsearch
endif

" 增量搜索
set incsearch
" 在搜索的时候忽略大小写
set ignorecase
" 高亮显示匹配的括号
set showmatch
" 显示行号
set number
set relativenumber
" 设置光标所在的行
set cursorline
" 显示未完成命令,可视模式里显示选择区域的大小
set showcmd
" Tab补全时命令行上行显示可能的匹配
set wildmenu

"set viminfo=
set history=1000
set nobackup
set noswapfile
" 文件被其他程序修改时自动载入
set autoread

" 共享外部剪贴板
"set clipboard+=unnamed
" At the beginning and end of the file check modelines
set modeline

set autoindent
set smartindent
set cindent

set autochdir
set tags=tags;

if has('autocmd')
  filetype plugin indent on

  " Reload vimrc after it's been modified.
  autocmd bufwritepost *vimrc source $MYVIMRC
endif

" Open vimrc file
map  <S-F12> :e! $MYVIMRC<CR>
imap <S-F12> <Esc>:e! $MYVIMRC<CR>a

"source $VIMRUNTIME/mswin.vim
"behave mswin

"
let mapleader = ","
nnoremap <F1> <nop>

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" Open tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
nnoremap <C-tab> :bn<CR>
nnoremap <C-S-tab> :bp<CR>

" nerdtree and nerdtree-git-plugin
nnoremap <F2> :NERDTreeToggle<CR>

" syntax/python.vim 
let g:python_highlight_all = 1
let b:python_version_2 = 1

" syntax/c.vim std_c.zip
let c_syntax_for_h = 1
let c_C99 = 1
let c_cpp_warn = 1
let c_warn_8bitchars = 1
let c_warn_multichar = 1
let c_warn_digraph = 1
let c_warn_trigraph = 1
let c_space_errors = 1
let c_minlines = 200

