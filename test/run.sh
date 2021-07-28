#!/usr/bin/env bash

# set -x

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Set a temp vim config where the plugin is
# sourced directly, instead of using nvim plugin
# standard path
nvim -Nu <(cat << EOF
filetype off
set rtp+=~/.local/share/nvim/plugged/vader.vim
source ${SCRIPTPATH}/../plugin/piano-chords-latex.vim
filetype plugin indent on
syntax enable
EOF
) -c 'Vader! test/test.vader' > /dev/null
