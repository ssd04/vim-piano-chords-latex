
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

" Default latex package
let g:piano_chords_latex_package = "songs"
let g:piano_chords_delete_empty_lines = 0

function! s:setup_piano_chords_buffer()
endfunction

function! s:replace_chords(line)
    let l:line = a:line

    let l:num_spaces = count(l:line, " ")
    let l:num_words = len(split(l:line))
    let l:num_chars = len(split(l:line, '\zs'))

    let l:start_op = "0g_diWji"
    let l:end_op = "\<esc>Pk"

    if g:piano_chords_latex_package == "songs"
        let l:songs_package_op = "\\[]"
    elseif g:piano_chords_latex_package == "leadsheets"
        let l:songs_package_op = "^{}"
    endif

    " Check if chord line
    if l:num_spaces > l:num_chars/2
        let l:num_chords = l:num_words

        while l:num_chords > 0
            let l:cmd = printf("normal! %s%s%s", l:start_op, l:songs_package_op, l:end_op)
            execute l:cmd
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

    " " Delete empty line from the selection
    " if g:piano_chords_delete_empty_lines == 1
    "     " call deletebufline("%", l:empty_line_index)
    "     execute "normal! dd"
    " endif
endfunction

function! s:delete_lines_by_index(line_indices)
    let l:line_indices = a:line_indices

    " Delete empty line from the selection
    for i in l:line_indices
        if i != 0
            echo "Do it ". i
            call deletebufline("%", i, i)
        endif
    endfor
endfunction

function! s:initial_setup()
endfunction

command! -nargs=* -range -bang PianoChordsToLatex <line1>,<line2>call <SID>setup_piano_chords()

let &cpo = s:save_cpo
unlet s:save_cpo
