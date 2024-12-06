# Standard for Dark/Light Preference in Terminals

## Syntax

<code>**CLITHEME** = ( **"dark"** | **"light"** | **"auto"** ) [ **":"** _modifier_ ]*</code>

The value is interpreted as follows:
- **"dark"**: Use colors optimized for a dark background.
- **"light"**: Use colors optimized for a light background.
- **"auto"**: Attempt to auto-detect the theme using `OSC 11` or a similar mechanism when appropriate.
- _unset_ or _unrecognized_: Treat the same as **"auto"**.

Zero or more modifiers preceded by a **":"** may follow one of the keywords.
Unrecognized modifiers must be ignored.

<!--

## Implementors

### Programs

; - delta
;   https://dandavison.github.io/delta/
; - bat
;   https://github.com/sharkdp/bat

### Libraries

- [terminal-colorsaurus](https://crates.io/crates/terminal-colorsaurus)

-->

## Notes

1. Standard for ANSI Colors in Terminals \
   <https://bixense.com/clicolors/>
1. Dark and Light Mode detection \
   <http://contour-terminal.org/vt-extensions/color-palette-update-notifications/>
