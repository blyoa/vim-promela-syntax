# vim-promela-syntax
This plugin provides additional keyword highlight to Vim's built-in [syntax/promela.vim](https://github.com/vim/vim/blob/de59ba33aa3b94f2757dbf3451682d762c15ebcf/runtime/syntax/promela.vim)

## Added keywords
- Built-in Functions (printf, get\_priority, set\_priority, etc...)
- Constants (1234, "Hidden", true, false)
- Macro (#define, #include, etc...)
- Predefined Variables (\_, \_pid, \_nr\_pr, etc...)

and the other missing keywords.

## Installation
### Install with [NeoBundle](https://github.com/Shougo/neobundle.vim)
Add to vimrc:
```VimL
NeoBundle 'blyoa/vim-promela-syntax'
```

## Reference
This syntax file is based on:
- [$VIMRUNTIME/syntax/c.vim](https://github.com/vim/vim/blob/de59ba33aa3b94f2757dbf3451682d762c15ebcf/runtime/syntax/c.vim)
- [$VIMRUNTIME/syntax/promela.vim](https://github.com/vim/vim/blob/de59ba33aa3b94f2757dbf3451682d762c15ebcf/runtime/syntax/promela.vim)

