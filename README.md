
# vim-piano-chords-latex

A simple text to latex syntax Vim plugin.

Since most of the songs with chords are set up in a text format, I decided to
create a small Vim plugin to convert the text to latex songs format.

## Installation

Use any plugin manager.

Example using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'ssd04/vim-piano-chords-latex'
```

## Usage

```vim
:PianoChordsToLatex
```

## Testing

Testing is performed using Vader package.

### Prerequisite

* [Vader.vim](https://github.com/junegunn/vader.vim)

### Run

```
make test-newenv
```

## License

MIT
