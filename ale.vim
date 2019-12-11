let g:ale_linters = {
\   'ruby': ['brakeman', 'reek', 'rubocop', 'ruby', 'solargraph']
\}
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

highlight ALEWarning ctermbg=DarkMagenta
