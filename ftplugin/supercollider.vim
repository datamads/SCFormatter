" ----------------------
"
" SCFORMATTER
"
" A very rough and opinionated SuperCollider code autoformatter based on regex
"
"-----------------------


" make sure there's a space between the end of a word and the char sign on assignment
fun! SCPadPreChar(char)
    " au BufWritePre <buffer> silent! %s/\v\S\zs\=/ =/gg
    silent execute '%s/\v\S\zs\' . a:char . '/ ' . a:char . '/ge'
endfun

" make sure there's a space between the beginning of a word following the char sign on assignment
fun! SCPadPostChar(char)
    " au BufWritePre <buffer> silent! %s/\v\=\ze\S/= /gg
    silent execute '%s/\v\' . a:char . '\ze\S/' . a:char . ' /ge'
endfun

" Useful when the padding function makes unnecessary padding
fun! SCRestorePad(from, to)
    silent execute '%s/\v' . a:from . '/' . a:to . '/ge'
endfun

augroup sc
    autocmd!
    "-----------
    " PADDING AROUND OPERATORS
    "-----------

    " =
    au BufWritePre <buffer> call SCPadPreChar('=')
    au BufWritePre <buffer> call SCPadPostChar('=')

    " Restore ===
    au BufWritePre <buffer> call SCRestorePad('\=\s\=\s\=', '===')

    " Restore ==
    au BufWritePre <buffer> call SCRestorePad('\=\s\=', '==')

    " !
    au BufWritePre <buffer> call SCPadPreChar('!')
    au BufWritePre <buffer> call SCPadPostChar('!')

    " +
    au BufWritePre <buffer> call SCPadPreChar('+')
    au BufWritePre <buffer> call SCPadPostChar('+')

    " Restore +++
    au BufWritePre <buffer> call SCRestorePad('\+\s\+\s\+', '+++')

    " Restore ++
    au BufWritePre <buffer> call SCRestorePad('\+\s\+', '++')

    " -
    au BufWritePre <buffer> call SCPadPreChar('-')
    au BufWritePre <buffer> call SCPadPostChar('-')

    " %
    au BufWritePre <buffer> call SCPadPreChar('%')
    au BufWritePre <buffer> call SCPadPostChar('%')

    " [
    au BufWritePre <buffer> call SCPadPostChar('[')
    
    " ]
    au BufWritePre <buffer> call SCPadPreChar(']')

    " *
    au BufWritePre <buffer> call SCPadPreChar('*')
    au BufWritePre <buffer> call SCPadPostChar('*')

    " <
    au BufWritePre <buffer> call SCPadPreChar('<')
    au BufWritePre <buffer> call SCPadPostChar('<')

    " Restore <<<* 
    au BufWritePre <buffer> call SCRestorePad('\<\s\<\s\<\s\*', '\<\<\<\*')

    " Restore <<< 
    au BufWritePre <buffer> call SCRestorePad('\<\s\<\s\<', '\<\<\<')

    " Restore <<* 
    au BufWritePre <buffer> call SCRestorePad('\<\s\<\s\*', '\<\<\*')

    " Restore << 
    au BufWritePre <buffer> call SCRestorePad('\<\s\<', '\<\<')

    " Restore <= 
    au BufWritePre <buffer> call SCRestorePad('\<\s\=', '\<\=')

    " >
    au BufWritePre <buffer> call SCPadPreChar('>')
    au BufWritePre <buffer> call SCPadPostChar('>')

    " Restore >>
    au BufWritePre <buffer> call SCRestorePad('\>\s\>', '\>\>')

    " Restore >=
    au BufWritePre <buffer> call SCRestorePad('\>\s\=', '\>\=')

    " Restore ==
    au BufWritePre <buffer> call SCRestorePad('\=\s\=', '==')

    " Restore !=
    au BufWritePre <buffer> call SCRestorePad('\!\s\=', '!=')

    " Restore !==
    au BufWritePre <buffer> call SCRestorePad('\!\s\=\=', '!==')

    " / 
    " TODO: How to do this without screwing file paths?
    "au BufWritePre <buffer> %s/\v\/\ze\S/\/ /ge
    "au BufWritePre <buffer> %s/\v\S\zs\// \//ge

    " Restore comments
    au BufWritePre <buffer> call SCRestorePad('\/\s\*', '\/\*')
    au BufWritePre <buffer> call SCRestorePad('\*\s\/', '\*\/')
    au BufWritePre <buffer> call SCRestorePad('\/\s\/', '\/\/')

    " Restore **
    au BufWritePre <buffer> call SCRestorePad('\*\s\*', '\*\*')

    " TODO &&
    " au BufWritePre <buffer> call SCPadPreChar('\&')
    " au BufWritePre <buffer> call SCPadPostChar('\&')
    " au BufWritePre <buffer> call SCRestorePad('\&\s\&', '&&')

    " TODO ||
    " au BufWritePre <buffer> call SCPadPreChar('\|\|')
    " au BufWritePre <buffer> call SCPadPostChar('\|\|')

    " @
    au BufWritePre <buffer> call SCPadPreChar('@')
    au BufWritePre <buffer> call SCPadPostChar('@')
    au BufWritePre <buffer> call SCRestorePad('\@\s\@', '@@')

    " ?
    au BufWritePre <buffer> call SCPadPreChar('?')
    au BufWritePre <buffer> call SCPadPostChar('?')

    " Restore ??
    au BufWritePre <buffer> call SCRestorePad('\?\s\?', '??')

    " Restore !?
    au BufWritePre <buffer> call SCRestorePad('\!\s\?', '!?')

    "-----------
    " END PADDING
    "-----------

    "-----------
    " OTHER FORMATTING
    "-----------
    " Delete spacing between { and | in func args
    au BufWritePre <buffer> %s/\v\{\s\|/{|/ge

    " If anything comes after ; move it to a new line
    au BufWritePre <buffer> %s/\v;\ze\S/;\r/ge

    " If anything comes after | move it to a new line
    " au BufWritePre <buffer> %s/\v\|\ze\S/\|\r/ge

    " Pad after commas
    au BufWritePre <buffer> call SCPadPostChar(',')

    " Move all comma dileneated items to newlines
    "au BufWritePre <buffer> %s/\s*\[.\{-}]/\=substitute(submatch(0), '\s\+', '\n', 'g')

    " Add space after colon
    au BufWritePre <buffer> %s/\v\:\ze\S/: /ge

    " Restore ://
    au BufWritePre <buffer> call SCRestorePad('\:\s\/\/', '\:\/\/')

    " Move \symbols to seperate lines
    " au BufWritePre <buffer> %s/\v,\S*\zs\\/\r\\/ge

    " Indent
    " au BufWritePre <buffer> execute "normal gg=G"

    "-----------
    " OTHER FORMATTING END
    "-----------
augroup END
