" Custom tabnr display that include the fixTabNameForLayer
" Rely on user variable g:fixTabNameForLayer which is a dict that
" contains the layer name for each tabnumber


function! airline#extensions#tabline#formatters#customTabnr#format(tab_nr_type, nr)
  let tabName = 'Unset'
  if has_key(g:usrTabName, a:nr)
    let tabName = g:usrTabName[a:nr]
  endif

  if a:tab_nr_type == 0 " nr of splits
    return (g:airline_symbols.space).tabName.'['.'%{len(tabpagebuflist('.a:nr.'))}'.']'
  elseif a:tab_nr_type == 1 " tab number
    return (g:airline_symbols.space).a:nr. ':' .(g:airline_symbols.space).tabName
  else " a:tab_nr_type == 2 " splits and tab number
    return (g:airline_symbols.space).a:nr. ':' .(g:airline_symbols.space).tabName.'['.'%{len(tabpagebuflist('.a:nr.'))}'.']'
  endif
endfunction
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
