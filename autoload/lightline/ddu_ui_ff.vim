function! s:get_ddu_info() abort
  let winid = &filetype =~# 'filter'
        \ ? g:->get('ddu#ui#ff#_filter_parent_winid', 0)
        \ : win_getid()
  let status = winid->getwinvar('ddu_ui_ff_status', {})
  return [winid, status]
endfunction

function! lightline#ddu_ui_ff#component() abort
  let [winid, status] = s:get_ddu_info()
  if empty(status) || &filetype !~# 'ddu'
    return ''
  endif
  let [cur, avail, max] = [line('.', winid), line('$', winid), status.maxItems]
  if [cur, avail] + winbufnr(winid)->getbufline(1) ==# [1, 1, '']
    let [cur, avail] = [0, 0]
  endif
  return ['[ddu-%s] %d/%d/%d %s',
        \ status.name, cur, avail, max, status.done ? '' : '[async]',
        \ ]->{ args -> call('printf', args) }()->trim()
endfunction
