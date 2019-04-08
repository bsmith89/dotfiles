setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=8
setlocal softtabstop=4
"setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with

let b:delimitMate_nesting_quotes = ['"', "'"]

" Don't reindent on ':' (which can show up in comments or dicts)
setlocal indentkeys-=:
