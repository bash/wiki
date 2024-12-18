+++
license = "CC0-1.0"
+++

# \[DRAFT] Standard for Dark/Light Preference in Terminals

CLI applications that make use of [truecolors] have to pick what background
they optimize for. todo

Some of these tools use `OSC 11` TODO

(TODO) currently tools that do dark/light detection have a variety of ways to override the automatic detection
(TODO) examples

This document aims to establish a standard environment variable for
users to communicate their dark/light preference to CLI applications.

It is not meant to replace automatic detection (using `OSC 11` or similar mechanisms)
but rather as a unified way of overriding said detection.

## Syntax

<code>**CLITHEME** = ( **"dark"** | **"light"** | **"auto"** ) [ **":"** _modifier_ ]*</code>

Zero or more modifiers preceded by a **":"** may follow one of the keywords.
Unrecognized modifiers must be ignored.

## Interpretation

The value is interpreted as follows:
- **"dark"**: \
  Use colors optimized for a dark background.
- **"light"**: \
  Use colors optimized for a light background.
- **"auto"**: (default) \
  Attempt to auto-detect the theme based on the terminal's background color (using `OSC 11`).
  Applications should not try to detect the theme if *stdout* is redirected.

Unrecognized values are treated the same as **"auto"**.

## How To Implement

```python
import os, sys

def cli_theme():
    theme_with_mod = os.environ.get('CLITHEME') or 'auto'
    theme = theme_with_mod.split(':')[0]
    if theme == 'dark' or theme == 'light':
        return theme
    elif sys.stdout.isatty():
        return detect_cli_theme()
    else:
        return 'dark'
```

## Issues

* systemd (for `run0`): todo
* bat: todo
* git-delta: todo
* glow: todo
* terminal-colorsaurus: todo
* Neovim: todo
* Helix: todo
* [difftastic](https://github.com/Wilfred/difftastic): todo
* [terminal-colorsaurus](https://crates.io/crates/terminal-colorsaurus): todo

## Notes

* (TODO) mention `COLORFGBG`


## See Also

1. Standard for ANSI Colors in Terminals \
   <https://bixense.com/clicolors/>
1. Dark and Light Mode detection \
   <http://contour-terminal.org/vt-extensions/color-palette-update-notifications/>

[truecolors]: https://github.com/termstandard/colors
