" Utilities {{{1

function! s:SID_PREFIX()
 return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

function! s:MakeDir(path, ...)
  if a:0 == 0
    echo '$ mkdir ' . a:path
    call mkdir(a:path)
  else
    echo '$ mkdir -m ' . a:1 . ' ' . a:path
    call mkdir(a:path, '', a:1)
  endif

  if exists('$SUDO_UID') && executable('chown')
    let owner = $SUDO_UID
    if exists('$SUDO_GID')
      let owner .= ':' . $SUDO_GID
    endif
    call system('chown ' . owner . ' ' . shellescape(a:path))
  endif
endfunction

function! s:GetScriptID(path)
  let scriptnames = ''
  redir => scriptnames
  silent scriptnames
  redir END
  let paths   = resolve(a:path) . '\|' . simplify(a:path)
  let pattern = '\zs\d\+\ze: \(' . escape(paths, '.') . '\)\n'
  return matchstr(scriptnames, pattern) + 0
endfunction

function! s:GetLocalFunctionName(name, path)
  let script_id = s:GetScriptID(a:path)
  return script_id ? ('<SNR>' . script_id . '_' . a:name) : ''
endfunction

function! s:GetLocalFunction(name, path)
  return function(s:GetLocalFunctionName(a:name, a:path))
endfunction

function! s:SearchInRuntimePath(path)
  for runtimepath in split(substitute(&runtimepath, '\', '/', 'g'), ',')
    let path = runtimepath . '/' . a:path
    if filereadable(path)
      return path
    endif
  endfor
  return ''
endfunction

function! s:CharctorCode4StatusLine()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  if has('iconv')
    let c = s:String2Hex(iconv(c, &enc, &fenc))
  else
    let c = s:String2Hex(c)
  endif
  return c == '' ? '-' : c
endfunction

" from :help eval-examples
" The function Nr2Hex() returns the hex string representation of a number.
function! s:Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunction

" from :help eval-examples
" The function String2Hex() converts each character in a string to a two
" character Hex string.
function! s:String2Hex(str)
  let out = ''
  for ix in range(strlen(a:str))
    let out .= s:Nr2Hex(char2nr(a:str[ix]))
  endfor
  return out
endfunction








" Initialization {{{1

" Pre Bundle {{{2

let $vim_tmp_dir = expand('~/tmp/vim')
if !isdirectory($vim_tmp_dir)
  call s:MakeDir($vim_tmp_dir)
endif

if has('vim_starting')
  set nocompatible
endif

set runtimepath&

if has('win32')
  set runtimepath-=~/vimfiles
  set runtimepath-=~/vimfiles/after
  set runtimepath^=~/.vim
  set runtimepath+=~/.vim/after
endif

augroup AUVIMRC
  autocmd!
augroup END

let s:ismac = has('mac') ||
      \ executable('uname') && system('uname') ==# "Darwin\n"




" NeoBundle {{{2

if executable('git')
  let $bundle_dir = $vim_tmp_dir . '/bundle'
  if !isdirectory($bundle_dir)
    call s:MakeDir($bundle_dir)
  endif

  if !isdirectory($bundle_dir . '/neobundle.vim')
    let s:command = 'git clone https://github.com/Shougo/neobundle.vim.git ' . $bundle_dir . '/neobundle.vim'
    echo '$ ' . s:command
    echo 'cloning ...'
    call system(s:command)
  endif

  set runtimepath+=$bundle_dir/neobundle.vim
  call neobundle#begin($bundle_dir)

  NeoBundleFetch 'Shougo/neobundle.vim'

  NeoBundle 'Shougo/vimproc.vim', 'ver.8.0', {
        \ 'build' : {
        \     'windows' : 'tools\\update-dll-mingw',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make -f make_mac.mak',
        \     'linux' : 'make',
        \     'unix' : 'gmake',
        \    },
        \ }

  " edit
  NeoBundle 'Align'
  NeoBundle 'Shougo/neocomplcache', 'ver.8.0'
  NeoBundle 'deris/vim-rengbang'
  NeoBundle 'm4i/vim-fakeclip', 'clip-client'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'tpope/vim-abolish'
  NeoBundle 'tpope/vim-endwise'

  " filetype
  NeoBundle 'Glench/Vim-Jinja2-Syntax'
  NeoBundle 'fatih/vim-go'
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'leafgarland/typescript-vim'
  NeoBundle 'hashivim/vim-terraform'
  NeoBundle 'slim-template/vim-slim'
  NeoBundle 'tpope/vim-haml'
  NeoBundle 'tpope/vim-rails'
  NeoBundle 'zaiste/tmux.vim'
  "NeoBundle 'Javascript-Indentation'
  "NeoBundle 'vim-creole'

  " unite
  NeoBundle 'Shougo/unite.vim', 'ver.6.1'
  NeoBundle 'Shougo/unite-outline', 'f03cfe4'
  NeoBundle 'tsukkee/unite-help', '5a8dc6c'
  NeoBundle 'tsukkee/unite-tag', '0.2.0'

  " visual
  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'tomasr/molokai'

  " misc
  NeoBundle 'AnsiEsc.vim'
  NeoBundle 'Shougo/vimfiler', 'ver.4.1'
  NeoBundle 'm4i/HierarchicalBackup'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'vim-jp/vimdoc-ja'
  NeoBundle 'xolox/vim-session'
  NeoBundle 'xolox/vim-misc'
  NeoBundle 'wakatime/vim-wakatime'

  "if has('ruby')
  "  NeoBundle 'fkfk/rbpit.vim'
  "endif

  call neobundle#end()

  NeoBundleCheck
endif

" mayu.vim: https://github.com/januswel/dotfiles/tree/master/.vim




" Post Bundle {{{2

syntax enable

if &guioptions !~# 'M'
  " ref. MacVim.app/Contents/Resources/vim/vimrc
  set guioptions+=M
  filetype plugin indent on
  set guioptions-=M
else
  filetype plugin indent on
endif

let mapleader = ' '








" Options {{{1

" search
set ignorecase
set smartcase
set hlsearch
set noincsearch
set wrapscan

" backup
set backup
set backupdir&
set backupdir^=$vim_tmp_dir/backup

" swap
set directory&
set directory^=$vim_tmp_dir/swap//

" undo
set undodir=$vim_tmp_dir/undo

" indent
set autoindent
set smartindent
set shiftwidth=8
set softtabstop=8
set tabstop=8

" editing
set backspace=indent,eol,start
set noexpandtab
set nrformats=alpha,hex
set showmatch
set virtualedit&
set virtualedit+=block

" content display
set ambiwidth=double
set list
set listchars=tab:>-,trail:!,nbsp:!
set nowrap
set wildmenu
execute "set colorcolumn=" . join(range(81, 100), ',')

" frame display
set laststatus=2
set nonumber
set ruler
set showcmd
set showmode
set showtabline=2

" misc
set background=dark
set fileformats=unix,dos,mac
set helplang=ja
set hidden
set history=100

if has('clipboard')
  set clipboard&
  if has('unnamedplus')
    set clipboard+=unnamedplus,unnamed
  else
    set clipboard+=unnamed
  endif
endif

if has('win32')
  set shellslash
end

autocmd AUVIMRC BufWritePre * let &backupext = strftime('~%Y%m%dT%H%M%S~')

" 重いのでコメントアウト
" http://d.hatena.ne.jp/thinca/20090530/1243615055
"augroup AUVIMRC
"  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
"  autocmd CursorHold,CursorHoldI,WinEnter * setlocal cursorline
"augroup END


" バックアップ用ディレクトリがなければ作成
let s:primary_backupdir = split(&backupdir, ',')[0]
if !isdirectory(s:primary_backupdir)
  call s:MakeDir(s:primary_backupdir, 0700)
endif

" スワップファイル用ディレクトリがなければ作成
let s:primary_directory = split(&directory, ',')[0]
if !isdirectory(s:primary_directory)
  call s:MakeDir(s:primary_directory, 0700)
endif

" undo 用ディレクトリがなければ作成
if !isdirectory(&undodir)
  call s:MakeDir(&undodir, 0700)
endif




" statusline {{{2

let &statusline  = ''
let &statusline .= '%m%r%h%w%y'
let &statusline .= '['
let &statusline .=   '%{&l:fileencoding == "" ? &encoding : &l:fileencoding}'
let &statusline .=   ':'
let &statusline .=   '%{&l:bomb ? "bom:" : ""}'
let &statusline .=   '%{&l:fileformat}'
let &statusline .= ']'
let &statusline .= ' %<%f'
let &statusline .= ' %='
let &statusline .= '['
let &statusline .=   '%B'
let &statusline .=   ':'
let &statusline .=   '%{' . s:SID_PREFIX() . 'CharctorCode4StatusLine()}'
let &statusline .= ']'
let &statusline .= ' %l,%c%V%5P'




" Encoding {{{2

" guess@kaoriya は euc-jp の判定に難有りなので最後に持ってくる

set encoding=utf-8

let s:enc_eucjp = 'euc-jp'
let s:enc_jisx  = 'iso-2022-jp'

if has('iconv')
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_eucjp = 'euc-jisx0213,euc-jp'
    let s:enc_jisx  = 'iso-2022-jp-3'
  endif
endif

let &fileencodings = s:enc_jisx
set fileencodings+=utf-8
let &fileencodings .= ',' . s:enc_eucjp
set fileencodings+=cp932,ucs-bom
if has('guess_encode')
  set fileencodings+=guess
endif

unlet s:enc_eucjp
unlet s:enc_jisx

" guess@kaoriya を利用しないと ascii のみのファイルが fileencodings の先頭の
" iso-2022-jp になってしまうため、その場合に utf-8 を使うようにする
function! s:ReCheckFileEncoding()
  if &fileencoding =~# '^iso-2022-jp' && search('[^\x01-\x7e]', 'n') == 0
    set fileencoding=utf-8
  endif
endfunction
autocmd AUVIMRC BufReadPost * call s:ReCheckFileEncoding()

" for Command Prompt
if !has('gui_running') && &term ==# 'win32'
  set termencoding=cp932
endif








" Unite Menu {{{1

let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.global = {
      \   'description': 'Global Menu',
      \   'command_candidates': [
      \     ['Toggle paste',   'set paste! | set paste?'],
      \     ['Edit .vimrc',    'tabedit $MYVIMRC'],
      \     ['Reload .vimrc',  'source $MYVIMRC'],
      \   ]
      \ }








" Mappings {{{1

nnoremap <Leader>ve :<C-u>tabedit $MYVIMRC<CR>
nnoremap <Leader>vr :<C-u>source $MYVIMRC<CR>

nnoremap <C-h>      :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

noremap  j gj
noremap  k gk
noremap gj  j
noremap gk  k

nnoremap Y y$

" 検索語が画面の真ん中に来るようにする
nnoremap n nzz
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" clear search highlight
nnoremap <silent> <Leader>/ :<C-u>let @/ = ''<CR>

" toggle paste
nnoremap <Leader>p :<C-u>set paste!<CR>:set paste?<CR>

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Delete>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>

nnoremap [tab]     <Nop>
nmap     <Leader>t [tab]
nnoremap <silent> [tab]1 :<C-u>tabnext 1<CR>
nnoremap <silent> [tab]2 :<C-u>tabnext 2<CR>
nnoremap <silent> [tab]3 :<C-u>tabnext 3<CR>
nnoremap <silent> [tab]4 :<C-u>tabnext 4<CR>
nnoremap <silent> [tab]5 :<C-u>tabnext 5<CR>
nnoremap <silent> [tab]6 :<C-u>tabnext 6<CR>
nnoremap <silent> [tab]7 :<C-u>tabnext 7<CR>
nnoremap <silent> [tab]8 :<C-u>tabnext 8<CR>
nnoremap <silent> [tab]9 :<C-u>tabnext 9<CR>
nnoremap <silent> [tab]0 :<C-u>tabnext 10<CR>
nnoremap <silent> [tab]! :<C-u>tabnext 11<CR>
nnoremap <silent> [tab]@ :<C-u>tabnext 12<CR>
nnoremap <silent> [tab]# :<C-u>tabnext 13<CR>
nnoremap <silent> [tab]$ :<C-u>tabnext 14<CR>
nnoremap <silent> [tab]% :<C-u>tabnext 15<CR>
nnoremap <silent> [tab]^ :<C-u>tabnext 16<CR>
nnoremap <silent> [tab]& :<C-u>tabnext 17<CR>
nnoremap <silent> [tab]* :<C-u>tabnext 18<CR>
nnoremap <silent> [tab]( :<C-u>tabnext 19<CR>
nnoremap <silent> [tab]) :<C-u>tabnext 20<CR>

nnoremap [setfenc]  <Nop>
nmap     <Leader>ef [setfenc]
nnoremap [setfenc]u  :<C-u>setlocal nobomb<CR>:setlocal fileencoding=utf-8<CR>
nnoremap [setfenc]6  :<C-u>setlocal bomb<CR>:setlocal fileencoding=ucs-2le<CR>
nnoremap [setfenc]s  :<C-u>setlocal fileencoding=cp932<CR>
nnoremap [setfenc]e  :<C-u>setlocal fileencoding=euc-jp<CR>
nnoremap [setfenc]j  :<C-u>setlocal fileencoding=iso-2022-jp<CR>
nnoremap [setfenc]n  :<C-u>setlocal fileformat=unix<CR>
nnoremap [setfenc]r  :<C-u>setlocal fileformat=mac<CR>
nnoremap [setfenc]rn :<C-u>setlocal fileformat=dos<CR>

command! -bang -bar -complete=file -nargs=? ReloadAsUtf8  edit<bang> ++enc=utf-8       <args>
command! -bang -bar -complete=file -nargs=? ReloadAsUtf16 edit<bang> ++enc=ucs-2le     <args>
command! -bang -bar -complete=file -nargs=? ReloadAsSjis  edit<bang> ++enc=cp932       <args>
command! -bang -bar -complete=file -nargs=? ReloadAsEucjp edit<bang> ++enc=euc-jp      <args>
command! -bang -bar -complete=file -nargs=? ReloadAsJis   edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? ReloadAsUnix  edit<bang> ++fileformat=unix <args>
command! -bang -bar -complete=file -nargs=? ReloadAsMac   edit<bang> ++fileformat=mac  <args>
command! -bang -bar -complete=file -nargs=? ReloadAsDos   edit<bang> ++fileformat=dos  <args>

nnoremap [reload]   <Nop>
nmap     <Leader>er [reload]
nnoremap [reload]u  :<C-u>ReloadAsUtf8<CR>
nnoremap [reload]6  :<C-u>ReloadAsUtf16<CR>
nnoremap [reload]s  :<C-u>ReloadAsSjis<CR>
nnoremap [reload]e  :<C-u>ReloadAsEucjp<CR>
nnoremap [reload]j  :<C-u>ReloadAsJis<CR>
nnoremap [reload]n  :<C-u>ReloadAsUnix<CR>
nnoremap [reload]r  :<C-u>ReloadAsMac<CR>
nnoremap [reload]rn :<C-u>ReloadAsDos<CR>









" FileTypes {{{1

" setfiletype {{{2

augroup AUVIMRC
  autocmd BufNewFile,BufRead /**/httpd/**/*.conf   setfiletype apache
  autocmd BufNewFile,BufRead /**/apache*/**/*.conf setfiletype apache

  autocmd BufNewFile,BufRead *.coffee.erb          setfiletype coffee

  autocmd BufNewFile,BufRead *.wiki                setfiletype creole

  autocmd BufNewFile,BufRead *.css.erb             setfiletype css

  autocmd BufNewFile,BufRead *.ctmpl               setfiletype gohtmltmpl

  autocmd BufNewFile,BufRead *.scaml               setfiletype haml

  autocmd BufNewFile,BufRead *.js.erb              setfiletype js

  " modula2 とかぶるので強制的に設定
  autocmd BufNewFile,BufRead *.md                  set filetype=markdown

  autocmd BufNewFile,BufRead *.cap                 setfiletype ruby
  autocmd BufNewFile,BufRead *.ru                  setfiletype ruby
  autocmd BufNewFile,BufRead .autotest             setfiletype ruby
  autocmd BufNewFile,BufRead .pryrc                setfiletype ruby
  autocmd BufNewFile,BufRead Berksfile             setfiletype ruby
  autocmd BufNewFile,BufRead Capfile               setfiletype ruby
  autocmd BufNewFile,BufRead Gemfile               setfiletype ruby
augroup END




" Indent {{{2

augroup AUVIMRC
  autocmd FileType ant        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType creole     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType eruby      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType go         setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType jsp        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType markdown   setlocal sw=4 sts=4 ts=4 et
  autocmd FileType objc       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType readline   setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=8 et
  autocmd FileType sass       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=8 et
  autocmd FileType scss       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType slim       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType terraform  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vb         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=8 et
  autocmd FileType wsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xhtml      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType xml        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=8 et
  autocmd FileType zsh        setlocal sw=2 sts=2 ts=2 et
augroup END




" Template {{{2

augroup AUVIMRC
  autocmd BufNewFile *.rb    0r ~/.vim/templates/template.rb
  autocmd BufNewFile Gemfile 0r ~/.vim/templates/Gemfile
augroup END




"" flymake {{{2
"
""augroup AUVIMRC
""  autocmd BufWritePost *.php         silent make -l %
""  autocmd BufWritePost *.pl,*.pm,*.t silent make
""  autocmd BufWritePost *.rb          silent make -cw %
""  autocmd FileType perl compiler perl
""  autocmd FileType php  compiler php
""  autocmd FileType ruby compiler ruby
""augroup END








" Commands {{{1

" Format JSON {{{2

if executable('jq')
  command! -range=% FormatJSON :<line1>,<line2>!jq .
else
  " http://wozozo.hatenablog.com/entry/2012/02/08/121504
  command! -range=% FormatJSON :<line1>,<line2>!python -m json.tool
endif

nnoremap <Leader>J :FormatJSON<CR>
vnoremap <Leader>J :FormatJSON<CR>




" SortCSS {{{2

if executable('sortcss')
  command! -range=% SortCSS :<line1>,<line2>!sortcss

  nnoremap [sortcss] <Nop>
  nmap     <Leader>s [sortcss]

  nnoremap [sortcss]g ggvG:SortCSS<CR>
  vnoremap [sortcss]g <Esc>ggvG:SortCSS<CR>
  nnoremap [sortcss]{ va{:SortCSS<CR>
  vnoremap [sortcss]{ a{:SortCSS<CR>
      nmap [sortcss]B <Leader>s{
      vmap [sortcss]B <Leader>s{
      nmap [sortcss]b <Leader>s{
      vmap [sortcss]b <Leader>s{
endif




" SudoWrite {{{2

command! SudoWrite write !sudo tee % >/dev/null








" Colors {{{1

" 行末の空白と全角スペースを赤で表示する
autocmd   AUVIMRC ColorScheme * highlight WhitespaceEOL ctermbg=Red guibg=Red
doautocmd AUVIMRC ColorScheme _
match WhitespaceEOL /\s\+$\|　/
autocmd AUVIMRC VimEnter,WinEnter * match WhitespaceEOL /\s\+$\|　/

if isdirectory($bundle_dir . '/vim-colors-solarized')
  let g:solarized_termcolors = 256
  let g:solarized_termtrans  = 1
  let g:solarized_contrast   = 'normal'
  let g:solarized_visibility = 'normal'
  let g:solarized_menu       = 0
  colorscheme solarized
endif








" Plugins {{{1

" Align {{{2

vnoremap [align]   <Nop>
vmap     <Leader>a [align]
vnoremap [align]=  :Align=<CR>
vnoremap [align]>  :Align=><CR>
vmap     [align]:  \tsp




" coffee-script {{{2

call add(g:unite_source_menu_menus.global.command_candidates,
      \ ['CoffeeWatch', 'CoffeeWatch vertical'])




" fugitive {{{2

nnoremap [fugitive] <Nop>
nmap     <Leader>g  [fugitive]

nnoremap [fugitive]b :<C-u>Gblame<CR>
nnoremap [fugitive]c :<C-u>Gcommit<CR>
nnoremap [fugitive]d :<C-u>Gdiff<CR>
nnoremap [fugitive]r :<C-u>Gread<CR>
nnoremap [fugitive]s :<C-u>Gstatus<CR>
nnoremap [fugitive]w :<C-u>Gwrite<CR>




" neocomplcache {{{2

let g:neocomplcache_enable_at_startup  = 1
let g:neocomplcache_enable_smart_case  = 1
"let g:neocomplcache_enable_auto_select = 1

if !exists('g:neocomplcache_same_filetype_lists')
  let g:neocomplcache_same_filetype_lists = {}
endif
let g:neocomplcache_same_filetype_lists.html = 'xhtml,css'
let g:neocomplcache_same_filetype_lists.css  = 'html'




" quickrun {{{2

nnoremap [quickrun] <Nop>
nmap     <Leader>q  [quickrun]

for [key, com] in items({
\   '[quickrun]x' : '>message',
\   '[quickrun]p' : '-runner shell',
\   '[quickrun]w' : '>buffer',
\   '[quickrun]v' : '>>buffer',
\   '[quickrun]q' : '',
\ })
  execute 'nnoremap <silent>' key ':QuickRun' com '-mode n<CR>'
  execute 'vnoremap <silent>' key ':QuickRun' com '-mode v<CR>'
endfor

let g:quickrun_config = {}

if s:ismac
  let g:quickrun_config.markdown = {
  \ 'outputter' : 'null',
  \ 'command'   : 'open',
  \ 'cmdopt'    : '--background -a',
  \ 'args'      : 'Marked',
  \ 'exec'      : '%c %o %a %s',
  \ }
  autocmd AUVIMRC BufWritePost *.md,*.markdown QuickRun
endif




"" rbpit {{{2
"
"if has('ruby')
"  if !isdirectory(expand('~/.pit'))
"    let g:loaded_rbpit = 1
"    let g:loaded_pitconfig = 1
"  else
"    ruby <<__END__
"      begin
"        require 'rubygems'
"        require 'pit'
"      rescue LoadError
"        VIM.command('let g:loaded_rbpit = 1')
"        VIM.command('let g:loaded_pitconfig = 1')
"      end
"__END__
"  endif
"endif




" session {{{2

let g:session_directory    = $vim_tmp_dir . '/sessions'
let g:session_default_name = substitute(fnamemodify(getcwd(), ':p:h'), '/', '__', 'g')
let g:session_autoload     = 'yes'
let g:session_autosave     = 'yes'




" Unite {{{2

let g:unite_winheight                  = 50
let g:unite_data_directory             = $vim_tmp_dir . '/unite'
let g:unite_source_grep_max_candidates = 200
let g:unite_source_history_yank_enable = 1

if executable('ag')
  let g:unite_source_grep_command       = 'ag'
  let g:unite_source_grep_default_opts  = '--nocolor --nogroup --hidden'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
  let g:unite_source_grep_command       = 'ack-grep'
  let g:unite_source_grep_default_opts  = '--no-heading --no-color -a'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap [unite]   <Nop>
nmap     <Leader>u [unite]

nnoremap <silent> <C-s>     :<C-u>UniteWithCurrentDir -buffer-name=files -start-insert buffer file_mru file file/new<CR>
nnoremap <silent> [unite]f  :<C-u>UniteWithBufferDir  -buffer-name=files -start-insert file file/new<CR>
nnoremap <silent> [unite]b  :<C-u>Unite               -buffer-name=files -start-insert buffer<CR>
nnoremap <silent> [unite]m  :<C-u>UniteWithCurrentDir -buffer-name=files -start-insert file_mru<CR>
nnoremap <silent> [unite]a  :<C-u>Unite               -buffer-name=files -start-insert file_rec/async<CR>
nnoremap <silent> [unite]k  :<C-u>Unite               -buffer-name=files -start-insert bookmark<CR>

nnoremap <silent> [unite]t  :<C-u>Unite               -buffer-name=tabs    -start-insert tab<CR>
nnoremap <silent> [unite]w  :<C-u>Unite               -buffer-name=windows -start-insert window<CR>

nnoremap <silent> [unite]"  :<C-u>Unite -buffer-name=register -no-start-insert register<CR>
nnoremap <silent> <Leader>p :<C-u>Unite -buffer-name=yank     -no-start-insert history/yank<CR>

"nnoremap <silent> * :<C-u>let @/ = '<C-r><C-w>'<Cr>:UniteWithCursorWord -buffer-name=search -no-start-insert -no-quit -winheight=20 line/fast<CR>
"nnoremap <silent> /         :<C-u>Unite               -buffer-name=search    -start-insert -no-quit -winheight=20 -auto-resize line/fast<CR>
"nnoremap <silent> *         :<C-u>UniteWithCursorWord -buffer-name=search -no-start-insert -no-quit -winheight=20 -auto-resize line/fast<CR>
nnoremap <silent> [unite]g  :<C-u>Unite               -buffer-name=search -no-start-insert -no-quit -winheight=20 -auto-resize grep:.<CR>
nnoremap <silent> [unite]i  :<C-u>Unite               -buffer-name=search -no-start-insert -no-quit -winheight=20 -auto-resize find:.<CR>

nnoremap <silent> [unite]n  :<C-u>Unite -buffer-name=menu -no-start-insert menu:global<CR>

nnoremap <silent> [unite]r  :<C-u>Unite -buffer-name=resume resume<CR>

nnoremap <silent> [unite]B  :<C-u>UniteBookmarkAdd %<CR>
nnoremap <silent> [unite]x  :<C-u>UniteClose search<CR>

" unite-help
nnoremap <silent> <C-h>      :<C-u>Unite               -buffer-name=help    -start-insert help<CR>
nnoremap <silent> <C-h><C-h> :<C-u>UniteWithCursorWord -buffer-name=help -no-start-insert help<CR>
" unite-outline
nnoremap <silent> [unite]o :<C-u>Unite -no-start-insert outline<CR>
" unite-tag
nnoremap <silent> [unite]g :<C-u>UniteWithCursorWord -buffer-name=tag tag<CR>

autocmd AUVIMRC FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  nmap <buffer> <ESC> <Plug>(unite_exit)

  inoremap <buffer><expr> <C-l> unite#do_action('tabopen')

  let l:unite = unite#get_current_unite()
  if l:unite.profile_name ==# 'files'
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  endif
endfunction




" vimfiler {{{2

let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_edit_action          = 'tabopen'
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_data_directory       = $vim_tmp_dir . '/vimfiler'








" Misc. {{{1

"" screen にファイル名を表示
"if exists('$STY')
"  autocmd AUVIMRC BufEnter * silent! execute '!echo -n "k%\\"'
"endif

"" ref. MacVim.app/Contents/Resources/vim/vimrc
"if has('mac') && exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
"  set iskeyword=@,48-57,_,128-167,224-235
"  let $PATH = simplify($VIM . '/../../MacOS') . ':' . $PATH
"endif

" Hatena::Let http://let.hatelabo.jp/help
augroup AUVIMRC
  autocmd BufWritePost */debuglet.js silent! execute '!debuglet.rb %'
  autocmd BufNewFile   */debuglet.js silent! execute 'r!debuglet.rb'
augroup END








" Finalization {{{1

if !has('vim_starting')
  call neobundle#call_hook('on_source')
endif

" reset to default
let mapleader = '\'

" vim: expandtab softtabstop=2 shiftwidth=2
" vim: fileencoding=utf-8 fileformat=unix
" vim: foldmethod=marker
