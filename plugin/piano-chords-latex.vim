
if exists("g:loaded_piano_chords_latex")
  finish
endif
let g:loaded_piano_chords_latex = 1

let s:save_cpo = &cpo
set cpo&vim

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

function! s:setup_piano_chords_buffer()
endfunction

function! s:replace_chords(line)
    let l:line = a:line

    let l:num_spaces = count(l:line, " ")
    let l:num_words = len(split(l:line))
    let l:num_chars = len(split(l:line, '\zs'))

    " Check if chord line
    if l:num_spaces > l:num_chars/2
        let l:num_chords = l:num_words

        while l:num_chords > 0
            execute "normal! g_diWji\\[]\<esc>Pk"
            let l:num_chords = l:num_chords - 1
        endwhile

        let l:empty_line_index = line('.')
    endif

    if exists("l:empty_line_index")
        return l:empty_line_index
    endif
endfunction

function! s:setup_piano_chords()
    setlocal noautoindent
    setlocal nocindent
    setlocal nosmartindent
    setlocal indentexpr=

    let l:empty_line_indices = []

    let l:line = getline('.')
    let l:empty_line_index = s:replace_chords(l:line)

    echo l:empty_line_index

    " call add(l:empty_line_indices, l:empty_line_index)

    " " Delete empty line from the selection
    " for i in l:empty_line_indices
    "     if i != 0
    "         echo "Do it ". i
    "         call deletebufline("%", i, i)
    "     endif
    " endfor
endfunction

command! -nargs=* -range -bang PianoChordsToLatex <line1>,<line2>call <SID>setup_piano_chords()

let &cpo = s:save_cpo
unlet s:save_cpo
