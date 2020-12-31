" Enable seeing-is-believing mappings only for Ruby
augroup seeingIsBelievingSettings
  autocmd!

  autocmd FileType ruby nmap <buffer> <F10> <Plug>(seeing-is-believing-mark-and-run)
  autocmd FileType ruby xmap <buffer> <F10> <Plug>(seeing-is-believing-mark-and-run)

  autocmd FileType ruby nmap <buffer> <F11> <Plug>(seeing-is-believing-mark)
  autocmd FileType ruby xmap <buffer> <F11> <Plug>(seeing-is-believing-mark)
  autocmd FileType ruby imap <buffer> <F11> <Plug>(seeing-is-believing-mark)

  autocmd FileType ruby nmap <buffer> <F12> <Plug>(seeing-is-believing-run)
  autocmd FileType ruby imap <buffer> <F12> <Plug>(seeing-is-believing-run)
augroup END
