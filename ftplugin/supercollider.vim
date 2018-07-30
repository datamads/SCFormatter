" ----------------------
"
" SCFORMATTER
"
" A very rough and opinionated SuperCollider code autoformatter based on regex
"
"-----------------------


" make sure there's a space between the end of a word and the char sign on assignment
fun! SCPadPreChar(char)
    " au BufWrite <buffer> silent! %s/\v\S\zs\=/ =/gg
    execute '%s/\v\S\zs\' . a:char . '/ ' . a:char . '/ge'
endfun

fun! SCPadPreCharLoop(charlist)
    for i in a:charlist
        call SCPadPreChar(i)
    endfor
endfun

" make sure there's a space between the beginning of a word following the char sign on assignment
fun! SCPadPostChar(char)
    " au BufWrite <buffer> silent! %s/\v\=\ze\S/= /gg
    execute '%s/\v\' . a:char . '\ze\S/' . a:char . ' /ge'
endfun

" Useful when the padding function makes unnecessary padding
fun! SCRestorePad(from, to)
    execute '%s/\v' . a:from . '/' . a:to . '/ge'
endfun

" SUPERCOLLIDER AUTO FORMATTING


augroup sc
    autocmd!
    "-----------
    " PADDING AROUND OPERATORS
    "-----------

    " =
    au BufWrite <buffer> call SCPadPreChar('=')
    au BufWrite <buffer> call SCPadPostChar('=')

    " Restore ===
    au BufWrite <buffer> call SCRestorePad('\=\s\=\s\=', '===')

    " Restore ==
    au BufWrite <buffer> call SCRestorePad('\=\s\=', '==')

    " !
    au BufWrite <buffer> call SCPadPreChar('!')
    au BufWrite <buffer> call SCPadPostChar('!')

    " +
    au BufWrite <buffer> call SCPadPreChar('+')
    au BufWrite <buffer> call SCPadPostChar('+')

    " Restore +++
    au BufWrite <buffer> call SCRestorePad('\+\s\+\s\+', '+++')

    " Restore ++
    au BufWrite <buffer> call SCRestorePad('\+\s\+', '++')

    " -
    au BufWrite <buffer> call SCPadPreChar('-')
    au BufWrite <buffer> call SCPadPostChar('-')

    " %
    au BufWrite <buffer> call SCPadPreChar('%')
    au BufWrite <buffer> call SCPadPostChar('%')

    " *
    au BufWrite <buffer> call SCPadPreChar('*')
    au BufWrite <buffer> call SCPadPostChar('*')

    " <
    au BufWrite <buffer> call SCPadPreChar('<')
    au BufWrite <buffer> call SCPadPostChar('<')

    " Restore <<<* 
    au BufWrite <buffer> call SCRestorePad('\<\s\<\s\<\s\*', '\<\<\<\*')

    " Restore <<< 
    au BufWrite <buffer> call SCRestorePad('\<\s\<\s\<', '\<\<\<')

    " Restore <<* 
    au BufWrite <buffer> call SCRestorePad('\<\s\<\s\*', '\<\<\*')

    " Restore << 
    au BufWrite <buffer> call SCRestorePad('\<\s\<', '\<\<')

    " Restore <= 
    au BufWrite <buffer> call SCRestorePad('\<\s\=', '\<\=')

    " >
    au BufWrite <buffer> call SCPadPreChar('>')
    au BufWrite <buffer> call SCPadPostChar('>')

    " Restore >>
    au BufWrite <buffer> call SCRestorePad('\>\s\>', '\>\>')

    " Restore >=
    au BufWrite <buffer> call SCRestorePad('\>\s\=', '\>\=')

    " Restore ==
    au BufWrite <buffer> call SCRestorePad('\=\s\=', '==')

    " Restore !=
    au BufWrite <buffer> call SCRestorePad('\!\s\=', '!=')

    " Restore !==
    au BufWrite <buffer> call SCRestorePad('\!\s\=\=', '!==')

    " / 
    au BufWrite <buffer> %s/\v\/\ze\S/\/ /ge
    au BufWrite <buffer> %s/\v\S\zs\// \//ge

    " Restore comments
    au BufWrite <buffer> call SCRestorePad('\/\s\*', '\/\*')
    au BufWrite <buffer> call SCRestorePad('\*\s\/', '\*\/')
    au BufWrite <buffer> call SCRestorePad('\/\s\/', '\/\/')

    " Restore **
    au BufWrite <buffer> call SCRestorePad('\*\s\*', '\*\*')

    " TODO &&
    " au BufWrite <buffer> call SCPadPreChar('\&')
    " au BufWrite <buffer> call SCPadPostChar('\&')
    " au BufWrite <buffer> call SCRestorePad('\&\s\&', '&&')

    " TODO ||
    " au BufWrite <buffer> call SCPadPreChar('\|\|')
    " au BufWrite <buffer> call SCPadPostChar('\|\|')

    " @
    au BufWrite <buffer> call SCPadPreChar('@')
    au BufWrite <buffer> call SCPadPostChar('@')
    au BufWrite <buffer> call SCRestorePad('\@\s\@', '@@')

    " ?
    au BufWrite <buffer> call SCPadPreChar('?')
    au BufWrite <buffer> call SCPadPostChar('?')

    " Restore ??
    au BufWrite <buffer> call SCRestorePad('\?\s\?', '??')

    " Restore !?
    au BufWrite <buffer> call SCRestorePad('\!\s\?', '!?')

    "-----------
    " END PADDING
    "-----------

    "-----------
    " OTHER FORMATTING
    "-----------

    " If anything comes after ; move it to a new line
    au BufWrite <buffer> %s/\v;\ze\S/;\r/ge

    " If anything comes after | move it to a new line
    " au BufWrite <buffer> %s/\v\|\ze\S/\|\r/ge

    " Pad after commas
    au BufWrite <buffer> call SCPadPostChar(',')

    " Move all comma dileneated items to newlines
    "au BufWrite <buffer> %s/\w\zs,\ze./,\r/ge

    " Add space after colon
    au BufWrite <buffer> %s/\v\:\ze\S/: /ge

    " Move \symbols to seperate lines
    " au BufWrite <buffer> %s/\v,\S*\zs\\/\r\\/ge

    " Indent
    " au BufWrite <buffer> execute "normal gg=G"

    "-----------
    " OTHER FORMATTING END
    "-----------
augroup END

