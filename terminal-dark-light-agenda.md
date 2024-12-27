# Terminal Auto Dark/Light Mode Agenda

**Goal: Terminal Applications Should Automatically Adapt To Dark/Light Mode.**

This page is a place for me to collect links / resources and have a direct jumping off point to the different PRs / issues.

## Products
* [terminal-colorsaurus]: A Rust library that answers the question "Is this terminal dark or light?".
* [terminal-trx]: A Rust library that provides a readable and writable handle to the current tty.
* [Continuous Color Reporting]: Specification for an extension to OSC 4, 10...19 for continously receiving updates when the color changes.
* [Exhaustive List of DEC Modes][dec-modes]: An exhaustive list of all DEC (private) modes that are encountered in the wild.

## Contributions
* (PR) [delta]: [Detect Dark/Light Mode from Terminal][delta-pr]
* (PR) [bat]: [Choose Theme Based on The Terminal's Color Scheme](https://github.com/sharkdp/bat/pull/2896)
* (PR) [zed]: [terminal: Retain relative order of responses](https://github.com/zed-industries/zed/pull/16456)
* (PR) [lazygit]: [Set the `TERM` env variable](https://github.com/jesseduffield/lazygit/pull/3420)
* (PR) [terminology]: [Unify format of responses to OSC 10 and OSC 11 / 12 queries](https://git.enlightenment.org/enlightenment/terminology/pulls/15)
* (Issue) [cosmic-term]: [Terminal reports incorrect background color](https://github.com/pop-os/cosmic-term/issues/391)
* (PR) [contour]: [docs: Add adoption state for dark/light mode notifications](https://github.com/contour-terminal/contour/pull/1678)
* (Issue) [tabby]: [Terminal reports incorrect background color when queried with `OSC 11`](https://github.com/Eugeny/tabby/issues/10121)

[bat]: https://github.com/sharkdp/bat
[delta]: https://github.com/dandavison/delta
[zed]: https://github.com/zed-industries/zed
[delta-pr]: https://github.com/dandavison/delta/pull/1615
[terminal-colorsaurus]: https://github.com/bash/terminal-colorsaurus
[terminal-trx]: https://github.com/bash/terminal-trx
[Continuous Color Reporting]: https://github.com/bash/continuous-color-reporting
[dec-modes]: /dec-modes
[lazygit]: https://github.com/jesseduffield/lazygit
[terminology]: http://www.enlightenment.org/about-terminology
[cosmic-term]: https://github.com/pop-os/cosmic-term
[contour]: https://github.com/contour-terminal/contour
[tabby]: https://tabby.sh/
