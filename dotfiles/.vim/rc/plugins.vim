set runtimepath+=~/.local/share/vim/plug
if !filereadable(expand('~/.local/share/vim/plug/autoload/plug.vim'))
  silent !curl -fsSL --create-dirs -o ~/.local/share/vim/plug/autoload/plug.vim
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.local/share/vim/plugged')

Plug 'Shougo/denite.nvim', { 'commit': '1b24883' }
Plug 'bronson/vim-trailing-whitespace'
Plug 'junegunn/vim-easy-align'
Plug 'm4i/gitbackup'
Plug 'nanotech/jellybeans.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-jp/vimdoc-ja'

call plug#end()

let s:__dir__ = expand('<sfile>:p:h')
for [s:name, s:plug] in items(g:plugs)
  if isdirectory(s:plug.dir)
    let s:file = s:__dir__ . '/plugins/' . s:name . '.vim'
    if filereadable(s:file)
      execute 'source ' . s:file
    endif
  endif
endfor
