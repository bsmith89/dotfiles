let g:markdown_fenced_languages = ['css', 'javascript',
                                  \'js=javascript', 'json=javascript',
                                  \'xml', 'html', 'python', 'make',
                                  \'shell=sh', 'bash=sh', 'sh',
                                  \'makefile=make',
                                  \'sql']
let b:delimitMate_nesting_quotes = ['`']
setlocal shiftwidth=4
" TODO: Style header in YAML instead of md

function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "="
endfunction
au BufEnter *.md setlocal foldexpr=MarkdownLevel()
au BufEnter *.md setlocal foldmethod=expr

let g:tagbar_type_markdown = {
            \ 'ctagstype' : 'markdown',
            \ 'kinds' : [
                \ 'h:headings',
                \ 'l:links',
                \ 'i:images'
            \ ],
    \ "sort" : 0
    \ }

nmap <Leader>c o<!--<CR>--><Esc>O
nmap <Leader>C O<!--<CR>--><Esc>O
