" vimrc
" Maintainer: Wang Jun
" Last Change: 2021-07-14

set nocompatible

if has('autocmd')
  " Remove ALL autocommands for the current group.
  au!
endif

if has('win32') || has("gui_running")
  source $VIMRUNTIME/mswin.vim
endif

language messages en_US.UTF-8

" 在一行开头按退格键删除 indent,eol,start
set backspace=indent,eol,start
" 允许指定键跨越行边界: backspace, space
set whichwrap=b,s
" 多字节字符排版:分行,不插入空格
set formatoptions+=mM

" 尝试的字符编码列表
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,latin1
" 设置终端编码,指定键盘输入和显示的字符编码
let &termencoding = &encoding
" Vim 内部字符编码
set encoding=utf-8
" 把所有的"不明宽度"字符的宽度置为双倍字符宽度(中文字符宽度)
" need 'encoding' is unicode encoding
"set ambiwidth=double

if has('mouse')
  set mouse=a
endif

if &t_Co > 2 || has("gui_running")
  set t_Co=256
endif

syntax on
" 搜索结果高亮
set hlsearch

" 增量搜索
set incsearch
" 在搜索的时候忽略大小写
set ignorecase
" 高亮显示匹配的括号
set showmatch
" 显示行号
set number
"set relativenumber

" 显示未完成命令,可视模式里显示选择区域的大小
set showcmd
" Tab补全时命令行上行显示可能的匹配
set wildmenu

set history=1000
set nobackup
set noswapfile
" 文件被其他程序修改时自动载入
set autoread

set vb t_vb=

" TODO:剪贴板
"set clipboard+=unnamed
" At the beginning and end of the file check modelines
set modeline

set autoindent
set smartindent
set cindent
set smarttab
set shiftround

set linebreak
let &showbreak='↪ '

set autochdir
set tags=tags;

set foldmethod=indent
set foldlevel=99

if has("gui_running")
  " 高亮光标所在的行
  set cursorline

  " 显示特殊字符
  set list
  set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
endif

if has("gui_running")
  set guioptions-=T
  "set guioptions-=m

  " Windows GUI font settings
  if has("windows")
    set guifont=Iosevka:h13,
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
    set columns=120 lines=35
    " Only set once
    let g:cols_lines_already_setting = &columns
  endif

  try
    colorscheme pencil
    set background=light
  endtry

  set laststatus=2
  set statusline=%F%m%r%w[%Y]
  set statusline+=%=%l,%v\ [%{''.(&fenc!=''?&fenc:&enc).''}%{(&bomb?\",BOM\":\"\")}][%{&ff}][%p%%]

endif

if has('autocmd')
  filetype plugin indent on

  " Reload vimrc after it's been modified.
  autocmd bufwritepost $MYVIMRC source $MYVIMRC

  " File type autocmd
  autocmd Filetype c,cpp,h  setlocal expandtab cinoptions+=:0,g0,(0,w1 shiftwidth=4 tabstop=4
  autocmd Filetype asm      setlocal expandtab shiftwidth=4 tabstop=4
  autocmd Filetype python   setlocal expandtab shiftwidth=4 tabstop=4
  autocmd FileType vim      setlocal expandtab shiftwidth=2 tabstop=2
  autocmd Filetype sh       setlocal expandtab shiftwidth=2 tabstop=2
  autocmd Filetype yaml     setlocal expandtab shiftwidth=2 tabstop=2
endif

let mapleader = "\<SPACE>"

" Open vimrc file
map  <S-F12> :e! $MYVIMRC<CR>
imap <S-F12> <Esc>:e! $MYVIMRC<CR>a

" tab
nnoremap <C-TAB> :bn<CR>
nnoremap <C-S-TAB> :bp<CR>

" Toggle fold za?
if has('folding')
  nnoremap <LEADER><SPACE> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
endif

" quit
nnoremap <LEADER>q <ESC>:bd<CR>

" cpp syntax highlight settings
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1

" tag jump
nnoremap <LEADER>j <ESC>g<C-]>
nnoremap <LEADER>b <C-T>

" taglist
map <F2> :TlistToggle<CR>
imap <F2> <Esc>:TlistToggle<CR>

" vim:et:sw=2:ts=2:ff=unix:fenc=utf8:fdm=marker:
