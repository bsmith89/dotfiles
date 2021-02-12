" my filetype file
if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.md     setfiletype markdown
    au! BufRead,BufNewFile *.smk     setfiletype snakemake
augroup END
