+++
license = "CC0-1.0"
+++

# Standard for Dark/Light Preference in Terminals

CLI applications that make use of [truecolors] have to pick what background
they optimize for. Instead of making assumptions, some tools have started to detect dark/light mode
by querying the terminal.

There is currently no way to override/disable auto-detection
for all these tools in a single, standardized way.

This document aims to establish the `CLITHEME` environment variable as a way
for users to communicate their dark/light preference to CLI applications.

It is not meant to replace automatic detection.

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
- **"auto"**: (default) Attempt to auto-detect the theme. Applications should not try to detect the theme if *stdout* is redirected.

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

## Adoption

| Support | Tool / Library          | Notes              |
|---------|-------------------------|--------------------|
| unknown | [systemd] `run0`        | todo: create issue |
| unknown | [bat]                   | todo: create issue |
| unknown | [delta]                 | todo: create issue |
| unknown | [glow]                  | todo: create issue |
| unknown | [terminal-colorsaurus]  | todo: create issue |
| unknown | [delta]                 | todo: create issue |
| unknown | [Neovim]                | todo: create issue |
| unknown | [Helix]                 | todo: create issue |
| unknown | [difftastic]            | todo: create issue |

[systemd]: https://github.com/systemd/systemd
[bat]: https://github.com/sharkdp/bat
[delta]: https://github.com/dandavison/delta
[difftastic]: https://github.com/Wilfred/difftastic
[terminal-colorsaurus]: https://crates.io/crates/terminal-colorsaurus
[Neovim]: https://github.com/neovim/neovim
[glow]: https://github.com/charmbracelet/glow
[Helix]: https://github.com/helix-editor/helix
[difftastic]: https://github.com/Wilfred/difftastic

## Appendix

### Dark/Light Mode Detection

There are currently two methods for determining whether the terminal
uses a dark or light theme:

1. Query for the terminal's background color using `OSC 11; ? ST`
   and classify the returned color. This is widely supported.
   [reference](https://www.invisible-island.net/xterm/ctlseqs/ctlseqs.html#h3-Operating-System-Commands)
1. Query the theme mode directly using `CSI ? 996 n`.
   This is only supported by a handful of terminals.
   [reference](https://contour-terminal.org/vt-extensions/color-palette-update-notifications/)

### Why not `COLORFGBG`?

The `COLORFGBG` environment variable was originally introduced by [`urxvt`](https://man.archlinux.org/man/extra/rxvt-unicode/urxvt.1.en#COLORFGBG)
and is not widely implemented (Konsole and iTerm2 set it).

It takes the form `fg;bg` (e.g. `15;0` for dark and `0;15` for light).

As opposed to `CLITHEME`, it is an environment variable set by the terminal. However,
since environment variables are not updated, it may reflect an out-of-date value when the
terminal changes its theme whereas `OSC 11` and friends reflect up-to-date values.

It would thus be a bad idea to give `COLORFGBG` higher priority over escape sequence based detection.

### See Also

* [Standard for ANSI Colors in Terminals](https://bixense.com/clicolors/)

[truecolors]: https://github.com/termstandard/colors
