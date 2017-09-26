" viminfo
set viminfo&
set viminfo+=n~/.cache/vim/viminfo
if !isdirectory(expand('~/.cache/vim'))
  call mkdir(expand('~/.cache/vim'), 'p')
endif

" backup
set backup
set backupdir=~/.cache/vim/backup
autocmd vimrc BufWritePre * let &backupext = '@' . substitute(expand('%:p:h'), '/', '%', 'g')
if !isdirectory(&backupdir)
  call mkdir(&backupdir, '', 0700)
endif

" swap
set directory=~/.cache/vim/swap//
if !isdirectory(&directory)
  call mkdir(&directory, '', 0700)
endif

" undo
set undodir=~/.cache/vim/undo
if !isdirectory(&undodir)
  call mkdir(&undodir, '', 0700)
endif

" indent
set autoindent
set expandtab
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=4
set tabstop=8

" search
set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan

" editing
set backspace=indent,eol,start
set nrformats=bin,hex,alpha
set showmatch
set virtualedit&
set virtualedit+=block

" misc
set ambiwidth=double
set clipboard&
set colorcolumn=81,101,121
set cursorline
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-jp,cp932,default,latin1
set fileformats=unix,dos
set hidden
set history=100
set laststatus=2
set list
set listchars=tab:>-,trail:!,extends:>,precedes:<,nbsp:!
set mouse=
set nonumber
set nowrap
set ruler
set sessionoptions&
set sessionoptions-=blank
set sessionoptions-=options
set showcmd
set showmode
set showtabline=2
set wildmenu

" 24 bit true color
" うまくいかないのでコメントアウト
"if has('termguicolors')
"  set termguicolors
"  " see :help xterm-true-color
"  let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
"  let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
"endif
