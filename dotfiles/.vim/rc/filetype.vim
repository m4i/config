" setfiletype {{{1

augroup vimrc
  autocmd BufNewFile,BufRead Dockerfile* setfiletype dockerfile
  autocmd BufNewFile,BufRead *.ctmpl     setfiletype gohtmltmpl
  autocmd BufNewFile,BufRead *.scaml     setfiletype haml
  autocmd BufNewFile,BufRead *.cap       setfiletype ruby
  autocmd BufNewFile,BufRead .autotest   setfiletype ruby
  autocmd BufNewFile,BufRead .pryrc      setfiletype ruby
  autocmd BufNewFile,BufRead Berksfile   setfiletype ruby
  autocmd BufNewFile,BufRead Capfile     setfiletype ruby
augroup END


" Indent {{{1

augroup vimrc
  autocmd FileType ant        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType creole     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType dockerfile setlocal sw=8 sts=8 ts=8 noet
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


" Template {{{1

augroup vimrc
  autocmd BufNewFile *.rb    0r ~/.vim/templates/template.rb
  autocmd BufNewFile Gemfile 0r ~/.vim/templates/Gemfile
augroup END
