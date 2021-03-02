" semshi
let g:semshi#mark_selected_nodes = 0

function PythonHighlightColors()
    hi semshiLocal           ctermfg=209 guifg=#E5B26A
    hi semshiGlobal          ctermfg=150 guifg=#23C3F1 "00FF78
    hi semshiImported        ctermfg=214 guifg=#23C3F1 cterm=bold gui=bold
    hi semshiParameter       ctermfg=75  guifg=#E5B26A
    hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
    hi semshiFree            ctermfg=218 guifg=#ffafd7
    hi semshiBuiltin         ctermfg=207 guifg=#00E474
    hi semshiAttribute       ctermfg=49  guifg=#ffffff
    hi semshiSelf            ctermfg=176 guifg=#A77EED
endfunction
autocmd FileType python call PythonHighlightColors()
