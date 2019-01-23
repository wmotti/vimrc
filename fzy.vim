" fzy finds a file
function! FzyCommand(choice_command, vim_command) abort
    let l:callback = {
                \ 'window_id': win_getid(),
                \ 'filename': tempname(),
                \  'vim_command':  a:vim_command
                \ }

    function! l:callback.on_exit(job_id, data, event) abort
        bdelete!
        call win_gotoid(self.window_id)
        if filereadable(self.filename)
            try
                let l:selected_filename = readfile(self.filename)[0]
                exec self.vim_command . ' ' . l:selected_filename
            catch /E684/
            endtry
        endif
        call delete(self.filename)
    endfunction

    botright 10 new
    let l:term_command = a:choice_command . ' | fzy > ' .  l:callback.filename
    silent call termopen(l:term_command, l:callback)
    setlocal nonumber norelativenumber
    startinsert
endfunction

nnoremap <leader>e  :call FzyCommand("rg --files", ":e")<cr>
nnoremap <leader>vs :call FzyCommand("rg --files", ":vs")<cr>
nnoremap <leader>sp :call FzyCommand("rg --files", ":sp")<cr>

" fzy finds a buffer
function! FzyBuffer()
  let bufnrs = filter(range(1, bufnr("$")), 'buflisted(v:val)')
  let buffers = map(bufnrs, 'bufname(v:val)')
  call FzyCommand('echo "' . join(buffers, "\n") . '"', ":b")
endfunction

nnoremap <leader>b :call FzyBuffer()<cr>

" fzy finds a file containing the word under the cursor
function! FzyIdentifier()
  " Yank the word under the cursor into the z register
  normal "zyiw
  " Fuzzy match files in the current directory, starting with the word under
  " the cursor
  call FzyCommand("rg -l " . @z, ":e")
endfunction
nnoremap <c-g> :call FzyIdentifier()<cr>


" inspiration: https://github.com/garybernhardt/selecta/blob/master/EXAMPLES.md
