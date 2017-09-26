" 検索語が画面の真ん中に来るようにする
nnoremap n nzz
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" / の検索時に \ を不要に
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" clear search highlight
nnoremap <silent> <Leader>/ :<C-u>let @/ = ''<CR>

" move tab
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
