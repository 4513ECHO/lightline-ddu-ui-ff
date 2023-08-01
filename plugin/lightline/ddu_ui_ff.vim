if exists('g:loaded_lightline_ddu_ui_ff')
  finish
endif
let g:loaded_lightline_ddu_ui_ff = v:true

augroup lightline-ddu-ui-ff
  autocmd!
  autocmd CursorMoved ddu-ff-* call lightline#update() | redrawstatus
  autocmd User Ddu:redraw call lightline#update() | redrawstatus
augroup END
