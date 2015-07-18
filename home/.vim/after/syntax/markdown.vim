syn sync minlines=100

" I don't use indentation based markdown code blocks since I have fenced
" blocks
syntax clear markdownCodeBlock

" I want list markers to work at any depth
syn match markdownListMarker "\%(\t\| *\)[-*+]\%(\s\+\S\)\@=" contained
syn match markdownOrderedListMarker "\%(\t\| *\)\<\d\+\.\%(\s\+\S\)\@=" contained
