if exists('g:loaded_lightline_ddu_ui_ff')
  finish
endif
let g:loaded_lightline_ddu_ui_ff = v:true

augroup lightline-ddu-ui-ff
  autocmd!
  autocmd CursorMoved,TextChangedI ddu-ff-* call lightline#ddu_ui_ff#update()
augroup END
