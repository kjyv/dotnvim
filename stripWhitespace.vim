"automatically strip trailing whitespace upon saving

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python,latex,vim,lua,json autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
