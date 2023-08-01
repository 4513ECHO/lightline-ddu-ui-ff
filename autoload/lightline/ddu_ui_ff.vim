function! s:get_ddu_info() abort
  let winid = &filetype =~# 'filter'
        \ ? g:->get('ddu#ui#ff#_filter_parent_winid', 0)
        \ : win_getid()
  let winnr = win_id2win(winid)
  let status = winnr->getwinvar('ddu_ui_ff_status', {})
  return [winid, winnr, status]
endfunction

function! lightline#ddu_ui_ff#component() abort
  let [winid, winnr, status] = s:get_ddu_info()
  if empty(status) || &filetype !~# 'ddu'
    return ''
  endif
  let [cur, avail, max] = [line('.', winid), line('$', winid), status.maxItems]
  if [cur, avail] + winbufnr(winnr)->getbufline(1) ==# [1, 1, '']
    let [cur, avail] = [0, 0]
  endif
  return ['[ddu-%s] %d/%d/%d %s',
        \ status.name, cur, avail, max, status.done ? '' : '[async]',
        \ ]->{ args -> call('printf', args) }()->trim()
endfunction
