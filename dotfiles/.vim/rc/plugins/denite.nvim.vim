nnoremap <silent> <Leader>d :<C-u>Denite menu:denite<CR>
nnoremap <silent> <Leader>m :<C-u>Denite menu<CR>
vnoremap <silent> <Leader>m :<C-u>Denite menu<CR>

nnoremap [denite] <Nop>
nmap s [denite]

nnoremap <silent> [denite]s :<C-u>Denite -resume<CR>
nnoremap <silent> [denite]n :<C-u>Denite -resume -select=+1 -immediately<CR>
nnoremap <silent> [denite]p :<C-u>Denite -resume -select=-1 -immediately<CR>

nnoremap <silent> [denite]* :<C-u>DeniteCursorWord line<CR>
nnoremap <silent> [denite]/ :<C-u>Denite           line<CR>
nnoremap <silent> [denite]h :<C-u>DeniteCursorWord help<CR>
nnoremap <silent> [denite]r :<C-u>Denite           register<CR>

nnoremap <silent> [denite]b :<C-u>Denite
      \ -default-action=switch buffer<CR>

nnoremap <silent> [denite]c :<C-u>DeniteBufferDir
      \ -default-action=switch file file:new<CR>

nnoremap <silent> [denite]f :<C-u>Denite
      \ -default-action=switch -matchers=matcher_substring
      \ `finddir('.git', ';') == '' ? 'file_rec' : 'file_rec/git'`<CR>

nnoremap <silent> [denite]g :<C-u>Denite
      \ -auto-preview
      \ `finddir('.git', ';') == '' ? 'grep' : 'grep/git'`:::!<CR>

nnoremap <silent> [denite]G :<C-u>DeniteCursorWord
      \ -auto-preview -no-empty
      \ `finddir('.git', ';') == '' ? 'grep' : 'grep/git'`<CR>

" file_rec/git source
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])

" grep/git source
call denite#custom#alias('source', 'grep/git', 'grep')
call denite#custom#var('grep/git', 'command', ['git', 'grep'])
call denite#custom#var('grep/git', 'recursive_opts', [])
call denite#custom#var('grep/git', 'final_opts', [])

" key mappings
call denite#custom#map('normal', 'O', '<denite:do_action:open>',         'noremap')
call denite#custom#map('normal', 'S', '<denite:do_action:split>',        'noremap')
call denite#custom#map('normal', 'T', '<denite:do_action:tab>',          'noremap')
call denite#custom#map('normal', 'V', '<denite:do_action:vsplit>',       'noremap')
call denite#custom#map('normal', 'o', '<denite:do_action:switch>',       'noremap')
call denite#custom#map('normal', 's', '<denite:do_action:splitswitch>',  'noremap')
call denite#custom#map('normal', 't', '<denite:do_action:tabswitch>',    'noremap')
call denite#custom#map('normal', 'v', '<denite:do_action:vsplitswitch>', 'noremap')

" menu
call denite#custom#var('menu', 'menus', {
      \ 'denite': {
      \   'description': 'Denite commands',
      \   'command_candidates': [
      \      ['buffer',                'Denite buffer'],
      \      ['command',               'Denite command'],
      \      ['command_history',       'Denite command_history'],
      \      ['directory_rec',         'Denite directory_rec'],
      \      ['file',                  'Denite file'],
      \      ['file_old',              'Denite file_old'],
      \      ['file_rec',              'Denite file_rec'],
      \      ['filetype',              'Denite filetype'],
      \      ['grep',                  'Denite grep'],
      \      ['help',                  'Denite help'],
      \      ['line',                  'Denite line'],
      \      ['outline',               'Denite outline'],
      \      ['register',              'Denite register'],
      \      ['tag',                   'Denite tag'],
      \   ]
      \ },
      \ 'fileencoding': {
      \   'description': 'Set fileencoding',
      \   'command_candidates': [
      \      ['UTF-8',     'setlocal nobomb | setlocal fileencoding=utf-8'],
      \      ['UTF-16',    'setlocal bomb | setlocal fileencoding=ucs-2le'],
      \      ['Shift_JIS', 'setlocal fileencoding=cp932'],
      \      ['EUC-JP',    'setlocal fileencoding=euc-jp'],
      \      ['JIS',       'setlocal fileencoding=iso-2022-jp'],
      \      ['Unix',      'setlocal fileformat=unix'],
      \      ['Mac',       'setlocal fileformat=mac'],
      \      ['Dos',       'setlocal fileformat=dos'],
      \   ]
      \ },
      \ 'reload_with_encoding': {
      \   'description': 'Relaod with encoding',
      \   'command_candidates': [
      \     ['UTF-8',     'edit! ++encoding=utf-8'],
      \     ['UTF-16',    'edit! ++encoding=ucs-2le'],
      \     ['Shift_JIS', 'edit! ++encoding=cp932'],
      \     ['EUC-JP',    'edit! ++encoding=euc-jp'],
      \     ['JIS',       'edit! ++encoding=iso-2022-jp'],
      \     ['Unix',      'edit! ++fileformat=unix'],
      \     ['Mac',       'edit! ++fileformat=mac'],
      \     ['Dos',       'edit! ++fileformat=dos'],
      \   ]
      \ },
      \ 'misc': {
      \   'command_candidates': [
      \     ['Format JSON', 'FormatJSON'],
      \     ['sudo write', 'SudoWrite'],
      \     ['Reload .vimrc', 'source $MYVIMRC'],
      \   ]
      \ },
      \ })
