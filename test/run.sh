#!/usr/bin/env bash

nvim -Nu <(cat << EOF
filetype off
set rtp+=~/.local/share/nvim/plugged/vader.vim
set rtp+=~/.local/share/nvim/plugged/vim-piano-chords-latex
filetype plugin indent on
syntax enable
EOF
) -c 'Vader! test/*' > /dev/null
