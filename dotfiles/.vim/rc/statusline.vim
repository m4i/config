function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

function! s:CharctorCode()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  if has('iconv')
    let c = s:String2Hex(iconv(c, &enc, &fenc))
  else
    let c = s:String2Hex(c)
  endif
  return c == '' ? '-' : c
endfunction

" The function Nr2Hex() returns the hex string representation of a number.
" see :help eval-examples
function! s:Nr2Hex(nr)
  let n = a:nr
  let r = ''
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunction

" The function String2Hex() converts each character in a string to a two
" character Hex string.
" see :help eval-examples
function! s:String2Hex(str)
  let out = ''
  for ix in range(strlen(a:str))
    let out .= s:Nr2Hex(char2nr(a:str[ix]))
  endfor
  return out
endfunction

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
let &statusline .=   '%{' . s:SID_PREFIX() . 'CharctorCode()}'
let &statusline .= ']'
let &statusline .= ' %l,%c%V%5P'
