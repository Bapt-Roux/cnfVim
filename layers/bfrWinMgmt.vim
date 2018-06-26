" Layer for  buffers and windows Mgmt {{{
" External plugins load {{{
call dein#add('Shougo/denite.nvim')
"}}}

" Custom functions {{{
function! bfrWinMgmt#SetNumberDisplay() "{{{
" Varies the display of numbers.
"
" This is not a 'mode' specific setting, so a simple autocommand won't work.
" Numbers should not show up in a terminal buffer, regardless of if that
" buffer is in terminal mode or not.
  let l:buffername = @%
  if l:buffername =~ 'term://*'
    setlocal nonumber
    setlocal norelativenumber
  else
    setlocal number
    setlocal relativenumber
  endif
endfunction "}}}
" }}}

" Custom remap {{{
" }}}

augroup BfrWinAutocmd "{{{
  autocmd!
" Nvim terminal emulator {{{
" when in a neovim terminal, add a buffer to the existing vim session
" instead of nesting (credit justinmk)
autocmd VimEnter * if !empty($NVIM_LISTEN_ADDRESS) && $NVIM_LISTEN_ADDRESS !=# v:servername
  \ |let g:r=jobstart(['nc', '-U', $NVIM_LISTEN_ADDRESS],{'rpc':v:true})
  \ |let g:f=fnameescape(expand('%:p'))
  \ |noau bwipe
  \ |call rpcrequest(g:r, "nvim_command", "edit ".g:f)
  \ |call rpcrequest(g:r, "nvim_command", "call bfrWinMgmt#SetNumberDisplay()")
  \ |qa
  \ |endif

" turn numbers on for normal buffers; turn them off for terminal buffers
autocmd TermOpen,BufWinEnter * call bfrWinMgmt#SetNumberDisplay()
"}}}
augroup END
" }}}
" }}}
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0


