" File: autoload/ctrlp/funky/php.vim
" Description: adds PHP support to ctrlp's funky extension
" Author: ldavison
" License: The MIT License

let s:filter = [{ 'pattern': '\v\s*function\s+\w.+\s*\(',
              \   'filter': ['\v(^\s*)|(\s*\{.*)', '', 'g']}
\]

if get(g:, 'ctrlp_funky_php_closures') == "1"
    echomsg 'ctrlp_funky_php_closures: ' . get(g:, 'ctrlp_funky_php_closures')
    call extend(s:filter, [{ 'pattern': '\v\C\w.+\s*\=\s*function\s*\(',
                           \ 'filter': ['\v(^\s*)|(\s*\{.*)', '', 'g']}])
endif

if get(g:, 'ctrlp_funky_php_includes') == "1"
    echomsg 'ctrlp_funky_php_includes: ' . get(g:, 'ctrlp_funky_php_includes')
    call extend(s:filter, [{ 'pattern': '\v\C^\s*(require|include|require_once|include_once)[\t (]+.*[);]',
                           \ 'filter': []}])
endif

if get(g:, 'ctrlp_funky_php_classes') == "1"
  echomsg 'ctrlp_funky_php_classes: ' . get(g:, 'ctrlp_funky_php_classes')
  call extend(s:filter, [{ 'pattern': '\v\c^\s*%(<\w+>\s+){0,3}class\s+\S+',
                         \ 'filter': []}])
endif


function! ctrlp#funky#php#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#php#get_filter()
  return s:filter
endfunction

