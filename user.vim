" vim:et:sw=2:ts=2:ff=unix:fenc=utf8:
"
" Maintainer:
" Last Change:

if has('autocmd')
  filetype plugin indent on

  " 根据文件类型调用相关设置
  autocmd Filetype c,cpp,h    setlocal expandtab cinoptions+=:0,g0,(0,w1 shiftwidth=4 tabstop=4
  autocmd Filetype cs         setlocal expandtab shiftwidth=4 tabstop=4
  autocmd Filetype asm        setlocal expandtab shiftwidth=4 tabstop=4
  autocmd FileType vim        setlocal expandtab shiftwidth=2 tabstop=2
  autocmd Filetype m          setlocal expandtab shiftwidth=4 tabstop=4
  autocmd Filetype txt        setlocal nonu
  autocmd Filetype python     setlocal expandtab shiftwidth=4 tabstop=4
  "autocmd Filetype dosbatch   setlocal expandtab shiftwidth=4
  autocmd Filetype yaml       setlocal expandtab shiftwidth=4
  autocmd Filetype sh         setlocal expandtab shiftwidth=2 tabstop=2
  autocmd Filetype json       setlocal expandtab shiftwidth=2 tabstop=2


  " Detect file encoding based on file type
  autocmd BufReadPre  *.gb               call SetFileEncodings('cp936')
  autocmd BufReadPre  *.big5             call SetFileEncodings('cp950')
  autocmd BufReadPost *.gb,*.big5        call RestoreFileEncodings()
  autocmd BufReadPre  *.lds              set filetype=ld
  " 对于特定的文件设置fileencodings
  function! SetFileEncodings(encodings)
    let b:my_fileencodings_bak=&fileencodings
    let &fileencodings=a:encodings
  endfunction
  " 恢复fileencodings
  function! RestoreFileEncodings()
    let &fileencodings=b:my_fileencodings_bak
    unlet b:my_fileencodings_bak
  endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文件头自动更新
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 保存代码文件前自动修改最后修改时间
  autocmd BufWritePre *vimrc call TimeStamp(3,'"')
  autocmd BufWritePre *.cmake call TimeStamp(3,'#')
  autocmd BufWritePre CMakeLists.txt call TimeStamp(3,'#')
  "autocmd BufWritePre *.py call TimeStamp(5,'#')
  autocmd BufWritePre *.c,*.h call DateRefresh()

  "Last change用到的函数，返回时间，能够自动调整位置
  function! TimeStamp(...)
    "注释开始标志
    let sBegin = ''
    "注释结束标志
    let sEnd = ''
    let sDefaultLine = 2

    "第一个参数
    if a:0 >= 1
      let sDefaultLine = a:1
    endif
    "第二个参数
    if a:0 >= 2
      let sBegin = a:2.'\s*'
    endif
    "第三个参数
    if a:0 >= 3
      let sEnd = ' '.a:3
    endif

    let pattern = 'Last Change:.\+' . sEnd
    let pattern = '^\s*' . sBegin . pattern . '\s*$'
    let now = strftime('%Y-%m-%d', localtime()) " %Y-%m-%d %H:%M:%S
    let row = search(pattern, 'n')
    if row  == 0
      let now = a:2 . ' ' . 'Last Change: ' . now . sEnd
      call append(sDefaultLine, now)
    else
      let curstr = getline(row)
      let col = match( curstr , 'Last')
      let spacestr = repeat(' ',col - 1)
      let now = a:2 . spacestr . 'Last Change: ' . now . sEnd
      call setline(row, now)
    endif
  endfunction

  "C文件中doxygen 的@date更新
  fun! DateRefresh()
    let dox = search('^\/\*\*', 'n')
    if dox == 0
      return
    endif
    let pattern = '.\+ @date .\+'
    let now = strftime('%Y-%m-%d', localtime())
    let row = search(pattern, 'n')
    if row == 0
      return
    else
      let curstr = getline(row)
      let now = ' * @date ' . now
      call setline(row, now)
    endif
  endfun

  function! RunSingleFile()
    exec "w"
    if &filetype == 'python'
      exec "!python %"
    endif
  endif

endif

