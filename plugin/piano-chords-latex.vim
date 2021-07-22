
if exists("g:loaded_piano_chords_latex")
  finish
endif
let g:loaded_piano_chords_latex = 1

" function! SetupPianoChords() range
"     " '< and '> mark begin and end lines of most recent visually selected text.
"     " Using those we get text from visual selection and iterate over the lines.
"     for l:line in getline(line("'<"), line("'>"))
"         echo l:line
"         let l:num_chars = len(split(l:line, '\zs'))
"         echo split(l:line, '\zs')
"         echo count(getline("."), " ")
"         let l:num_words = len(split(l:line))
"         echo l:num_words l:num_chars

"         let l:chords = split(l:line)
"         echo l:chords
"     endfor
" endfunction

function! SetupPianoChordsEntireBuffer()
endfunction

function! ReplaceChords()
    let l:line = getline('.')

    let l:empty_line_indices = []

    let l:num_spaces = count(l:line, " ")
    let l:num_words = len(split(l:line))
    let l:num_chars = len(split(l:line, '\zs'))

    setlocal noautoindent
    setlocal nocindent
    setlocal nosmartindent
    setlocal indentexpr=

    " Check if chord line
    if l:num_spaces > l:num_chars/2
        let l:num_chords = l:num_words

        while l:num_chords > 0
            execute "normal! g_diWji\\[]\<esc>Pk"
            let l:num_chords = l:num_chords - 1
        endwhile

        call add(empty_line_indices, line('.'))
    endif

    return l:empty_line_indices
endfunction

function! SetupPianoChords()
    let l:empty_line_indices = ReplaceChords()

    " " Delete empty line from the selection
    " for i in l:empty_line_indices
    "     call deletebufline("%", i, i)
    " endfor

endfunction
