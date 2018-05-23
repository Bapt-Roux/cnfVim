" Core-theme load UI theme and statusbar {{{
" Statusbar load {{{
call dein#add('vim-airline/vim-airline') "{{{
let g:airline_powerline_fonts = g:cnf_nvim.powerline_fonts
let g:airline_section_b = ''
let g:airline_section_warning = ''
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '^V' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '^S' : 'S',
    \ }
"Buffer line
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#bufferline#overwrite_variables = 1
"Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'customTabName'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tabnr_formatter = 'customTabnr'
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s '
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnametruncate = 12
if g:cnf_nvim.syntaxcheck_plugin ==# 'syntastic'
  let g:airline#extensions#syntastic#enabled = 1
endif
"}}}
call dein#add('vim-airline/vim-airline-themes') "{{{
"}}}
"}}}

" UI theme {{{
set t_Co=256
try
  " run `:syntax` to view highlight
  if g:cnf_nvim.colorscheme ==# 'molokai' "{{{
    call dein#add('tomasr/molokai')
    let g:molokai_original = 1
    colorscheme molokai
    set background=dark
    highlight NonText ctermfg=235 guifg=#262626
    highlight SpecialKey ctermfg=235 guifg=#262626
    "highlight PmenuSel ctermfg=231 guifg=#FFFFFF
    highlight CTagsClass ctermfg=81 guifg=#66D9EF
    " }}}
  elseif g:cnf_nvim.colorscheme ==# 'solarized' "{{{
    call dein#add('altercation/vim-colors-solarized')
    " 16 color palette is recommended
    " <https://github.com/altercation/vim-colors-solarized>
    if g:cnf_nvim.force256 == 1
      let g:solarized_termcolors = 256
    else
      let g:solarized_termcolors = 16
    endif
    let g:solarized_termtrans = g:cnf_nvim.termtrans
    let g:solarized_degrade = 0
    set background=dark
    " <https://github.com/seanbell/term-tools/issues/2>
    " run `:help signify` to view signify highlight
    " run `:help highlight-groups` to view vim highlight
    colorscheme solarized
    if g:cnf_nvim.force256 == 1
      highlight NonText ctermfg=236 ctermbg=none
      highlight SpecialKey ctermfg=236 ctermbg=none
      highlight LineNr ctermfg=240 ctermbg=0
      highlight CursorLine ctermbg=0
      "highlight CursorLineNr
      highlight CTagsClass ctermfg=125
    else
      execute 'highlight! CTagsClass' . g:solarized_vars['fmt_none'] .
          \ g:solarized_vars['fg_magenta'] . g:solarized_vars['bg_none']

      " highlight lines in signify and vimdiff etc.
      "execute 'highlight! DiffAdd' . g:solarized_vars['fmt_none'] .
      "    \ g:solarized_vars['fg_green'] . g:solarized_vars['bg_base02']
      "execute 'highlight! DiffDelete' . g:solarized_vars['fmt_none'] .
      "    \ g:solarized_vars['fg_red']  . g:solarized_vars['bg_base02']
      "execute 'highlight! DiffChange' . g:solarized_vars['fmt_none'] .
      "    \ g:solarized_vars['fg_yellow'] . g:solarized_vars['bg_base02']

      " highlight signs in signify
      "execute 'highlight! SignifySignAdd' . g:solarized_vars['fmt_none'] .
      "    \ g:solarized_vars['fg_green'] . g:solarized_vars['bg_base02']
      "execute 'highlight! SignifySignDelete' .
      "    \ g:solarized_vars['fmt_none'] .
      "    \ g:solarized_vars['fg_red'] . g:solarized_vars['bg_base02']
      "execute 'highlight! SignifySignChange' .
      "    \ g:solarized_vars['fmt_none'] .
      "    \ g:solarized_vars['fg_yellow'] . g:solarized_vars['bg_base02']

      " indent guides
      let g:indent_guides_auto_colors = 0
      " bg_cyan
      execute 'autocmd VimEnter,Colorscheme * :highlight! IndentGuidesOdd' .
          \ g:solarized_vars['fmt_none'] . g:solarized_vars['fg_base03'] .
          \ g:solarized_vars['bg_base02']
      execute 'autocmd VimEnter,Colorscheme * :highlight! IndentGuidesEven' .
          \ g:solarized_vars['fmt_none'] . g:solarized_vars['fg_base03'] .
          \ g:solarized_vars['bg_base02']
    endif
    "}}}
  elseif g:cnf_nvim.colorscheme ==# 'spaceVim' "{{{
    call dein#add('liuchengxu/space-vim-dark')
    colorscheme space-vim-dark
    let g:space_vim_dark_background = 234
    hi Comment cterm=italic
    hi Normal     ctermbg=NONE guibg=NONE
    hi LineNr     ctermbg=NONE guibg=NONE
    hi SignColumn ctermbg=NONE guibg=NONE

  endif "}}}
catch
  set background=dark
  colorscheme default
endtry

"}}}
" }}}
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
