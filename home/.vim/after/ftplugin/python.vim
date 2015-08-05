setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=8
setlocal softtabstop=4
"setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with


" Re: Plug:scrooloose/syntastic
function! TogglePython3()
    if exists("b:syntastic_python_python_exec") && b:syntastic_python_python_exec=='python3'
        let b:syntastic_python_python_exec='python'
    else
        let b:syntastic_python_python_exec='python3'
    endif
    echom 'Syntastic syntax checker python set to' b:syntastic_python_python_exec
endfunction
nmap <leader>3 :call TogglePython3()<CR>

" PyLint is waaaaaay too slow when I've got a bunch of imports
let g:syntastic_python_checkers = ['pyflakes', 'pep8', 'python']
" let g:syntastic_python_checkers = ['python']
"let g:syntastic_aggregate_errors = 1

let b:delimitMate_nesting_quotes = ['"', "'"]

setlocal indentkeys-=:
