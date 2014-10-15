" Set default values of various global variables
if !exists("g:MarkdownAutoCompile")
    let g:MarkdownAutoCompile = 0
endif

if !exists("g:MarkdownCompileSilent")
    let g:MarkdownCompileSilent = 0
endif

if !exists("g:MarkdownCompileArgs")
    let g:MarkdownCompileArgs = [""]
endif

if !exists("g:MarkdownCompileToFmt")
    let g:MarkdownCompileToFmt = "html5"
endif

if !exists("g:MarkdownFlavor")
    let g:MarkdownFlavor = "markdown"
endif

let s:OutputExtension = {'html': 'html',
                    \    'html5': 'html',
                    \    'latex': 'tex',
                    \   }
" \default values

function! s:ConstructCompileCommand()
    let l:CompileCommand  = "pandoc "
    let l:CompileCommand .= join(g:MarkdownCompileArgs)
    let l:CompileCommand .= " -f "
    let l:CompileCommand .= g:MarkdownFlavor
    let l:CompileCommand .= " -t "
    let l:CompileCommand .= g:MarkdownCompileToFmt
    let l:CompileCommand .= " -o "
    let l:CompileCommand .= "%."
    let l:CompileCommand .= s:OutputExtension[g:MarkdownCompileToFmt]
    let l:CompileCommand .= " % "
    return l:CompileCommand
endfunction

function! g:CompileMarkdown()
    if !g:MarkdownCompileSilent
        execute "!" . s:ConstructCompileCommand()
        echo "***To silence this interruption..."
        \    ":let g:MarkdownCompileSilent=1***"
    else
        execute "silent !" . s:ConstructCompileCommand()
    endif
endfunction

if !exists("s:autocommands_loaded")
    let s:autocommands_loaded = 1
    augroup markdown
        au BufWritePost,FileWritePost *
        \   :if g:MarkdownAutoCompile |
        \        if &filetype == "markdown" |
        \            call g:CompileMarkdown() |
        \        endif |
        \    endif
    augroup END
endif
