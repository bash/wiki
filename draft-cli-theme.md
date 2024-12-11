# \[DRAFT] Standard for Dark/Light Preference in Terminals

(TODO) currently tools that do dark/light detection have a variety of ways to override the automatic detection
(TODO) examples

This document aims to establish a standard way for
users to communicate their dark/light preference to CLI applications.

It is not meant to replace automatic detection (using `OSC 11` or similar mechanisms)
but rather as a unified way of overriding said detection.

## Syntax

<code>**CLITHEME** = ( **"dark"** | **"light"** | **"auto"** ) [ **":"** _modifier_ ]*</code>

Zero or more modifiers preceded by a **":"** may follow one of the keywords.
Unrecognized modifiers must be ignored.

## Interpretation

The value is interpreted as follows:
- **"dark"**: Use colors optimized for a dark background.
- **"light"**: Use colors optimized for a light background.
- **"auto"**: Attempt to auto-detect the theme using `OSC 11` or a similar mechanism when appropriate.
- _unset_ or _unrecognized_: Treat the same as **"auto"**.

(TODO) tools may choose to only support dark and light and do nothing for auto.

## Issues

* systemd (for `run0`): todo
* bat: todo
* git-delta: todo
* glow: todo
* terminal-colorsaurus: todo
* Neovim: todo
* Helix: todo
* [difftastic](https://github.com/Wilfred/difftastic): todo

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

* (TODO) mention `COLORFGBG`


## See Also

1. Standard for ANSI Colors in Terminals \
   <https://bixense.com/clicolors/>
1. Dark and Light Mode detection \
   <http://contour-terminal.org/vt-extensions/color-palette-update-notifications/>
