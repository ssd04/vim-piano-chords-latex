
if exists("g:loaded_piano_chords_latex")
  finish
endif
let g:loaded_piano_chords_latex = 1

let s:save_cpo = &cpo
set cpo&vim

" Global variables defautls
let g:piano_chords_latex_package = "songs"
let g:piano_chords_delete_empty_lines = 1

function! s:initial_setup()
    setlocal noautoindent
    setlocal nocindent
    setlocal nosmartindent
    setlocal indentexpr=
endfunction

function! s:check_chords(line, line_index)
    let l:line = a:line
    let l:line_index = a:line_index

    let l:num_spaces = count(l:line, " ")
    let l:num_words = len(split(l:line))
    let l:num_chars = len(split(l:line, '\zs'))

    " Check if chord line
    if l:num_spaces > l:num_chars/2 && l:num_words >= 1
        let l:chord_line_index = l:line_index
    endif

    if exists("l:chord_line_index")
        return l:chord_line_index
    endif
endfunction

function! s:replace_chords(line, line_index)
    let l:line = a:line
    let l:line_index = a:line_index

    let l:start_op = "0g_diWji"
    let l:end_op = "\<esc>Pk"

    if g:piano_chords_latex_package == "songs"
        let l:songs_package_op = "\\[]"
    elseif g:piano_chords_latex_package == "leadsheets"
        let l:songs_package_op = "^{}"
    endif

    let l:num_chords = len(split(l:line))
    while l:num_chords > 0
        let l:cmd = printf("%dnormal! %s%s%s", l:line_index, l:start_op, l:songs_package_op, l:end_op)
        execute l:cmd
        let l:num_chords = l:num_chords - 1
    endwhile
endfunction

function! s:delete_lines_by_index(line_indices)
    let l:shift = 0
    for i in a:line_indices
        let l:cmd = printf("%dnormal! dd", i + l:shift)
        execute l:cmd
        let l:shift -= 1 
    endfor
endfunction

function! s:setup_piano_chords() range
    call s:initial_setup()

    let l:chord_line_indices = []

    for line_number in range(a:firstline, a:lastline)
        let l:line = getline(line_number)
        echo l:line

        let l:line_index = s:check_chords(l:line, line_number)
        if l:line_index != 0 
            call add(l:chord_line_indices, l:line_index)
        endif
    endfor

    echo l:chord_line_indices

    for line_number in l:chord_line_indices
        let l:line = getline(line_number)
        call s:replace_chords(l:line, line_number)
    endfor

    if g:piano_chords_delete_empty_lines == 1
        call s:delete_lines_by_index(l:chord_line_indices)
    endif
endfunction

command! -nargs=* -range -bang PianoChordsToLatex <line1>,<line2>call <SID>setup_piano_chords()

let &cpo = s:save_cpo
unlet s:save_cpo
