" Core-theme load UI theme{{{
call dein#add('tomasr/molokai')
call dein#add('altercation/vim-colors-solarized')
call dein#add('liuchengxu/space-vim-dark')

" UI theme function {{{
function! uiTheme#initMolokai() "{{{
    let g:molokai_original = 1
    colorscheme molokai
    set background=dark
    highlight NonText ctermfg=235 guifg=#262626
    highlight SpecialKey ctermfg=235 guifg=#262626
    "highlight PmenuSel ctermfg=231 guifg=#FFFFFF
    highlight CTagsClass ctermfg=81 guifg=#66D9EF
endfunction "}}}

function! uiTheme#initSolarized() "{{{
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
      let g:indent_guides_auto_colors = 0
      execute 'autocmd VimEnter,Colorscheme * :highlight! IndentGuidesOdd' .
          \ g:solarized_vars['fmt_none'] . g:solarized_vars['fg_base03'] .
          \ g:solarized_vars['bg_base02']
      execute 'autocmd VimEnter,Colorscheme * :highlight! IndentGuidesEven' .
          \ g:solarized_vars['fmt_none'] . g:solarized_vars['fg_base03'] .
          \ g:solarized_vars['bg_base02']
    endif
endfunction "}}}

function! uiTheme#initSpaceVim() "{{{
    colorscheme space-vim-dark
    let g:space_vim_dark_background = 234
    hi Comment cterm=italic
    hi Normal     ctermbg=NONE guibg=NONE
    hi LineNr     ctermbg=NONE guibg=NONE
    hi SignColumn ctermbg=NONE guibg=NONE
endfunction "}}}
"}}}

"Base loader {{{
set t_Co=256
try
  if g:cnf_nvim.colorscheme ==# 'molokai'
    call uiTheme#initMolokai()
  elseif g:cnf_nvim.colorscheme ==# 'solarized'
    call uiTheme#initsolarized()
  elseif g:cnf_nvim.colorscheme ==# 'spaceVim'
    call uiTheme#initSpaceVim()
  endif
catch
  set background=dark
  colorscheme default
endtry
" }}}

" }}}
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
