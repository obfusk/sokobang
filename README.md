<!-- {{{1 -->

    File        : README.md
    Maintainer  : Felix C. Stegerman <flx@obfusk.net>
    Date        : 2020-09-08

    Copyright   : Copyright (C) 2020  Felix C. Stegerman
    Version     : v0.2.1
    License     : AGPLv3+

<!-- }}}1 -->

[![GitHub Release](https://img.shields.io/github/release/obfusk/sokobang.svg?logo=github)](https://github.com/obfusk/sokobang/releases)
[![Android Build](https://github.com/obfusk/sokobang/workflows/Android/badge.svg)](https://github.com/obfusk/sokobang/actions?query=workflow%3AAndroid)
[![AGPLv3+](https://img.shields.io/badge/license-AGPLv3+-blue.svg)](https://www.gnu.org/licenses/agpl-3.0.html)
[![Sponsor](https://img.shields.io/badge/%E2%99%A5-support-violet.svg)](https://ko-fi.com/obfusk)

<!--
[![F-Droid Version](https://img.shields.io/f-droid/v/dev.obfusk.sokobang.svg)](https://f-droid.org/app/dev.obfusk.sokobang)
-->

## Description

sokobang - sokoban puzzle w/ bigbang.coffee

→ https://sokobang.obfusk.dev

<!--
[<img src="badges/google-play.png" alt="Get it on Google Play" height="60">](https://play.google.com/store/apps/details?id=dev.obfusk.sokobang)
[<img src="badges/fdroid.png" alt="Get it on F-Droid" height="60">](https://f-droid.org/app/dev.obfusk.sokobang)
-->

Sokoban(g) is a sokoban puzzle -- with images and levels from
[ksokoban](https://projects.kde.org/projects/playground/games/ksokoban/repository)
-- written in coffeescript using the
[bigbang.coffee](https://github.com/obfusk/bigbang.coffee) library.

## Dependencies

To run the game, you will need bigbang.coffee; when using git, use
`git submodule update --init` to fetch and use the dependencies.

## TODO

* further optimize drawing?
* reload level?
* improve render_end?
* improve state handling in start.coffee?
* specs/docs?
* ...

## License

### Code

© Felix C. Stegerman

[![AGPLv3+](https://www.gnu.org/graphics/agplv3-155x51.png)](https://www.gnu.org/licenses/agpl-3.0.html)

### Images & Levels

See [`README.ksokoban`](README.ksokoban).

### Person Image

© Google Inc.

[Apache 2.0](https://github.com/googlefonts/noto-emoji/blob/master/LICENSE)

NB: `person.png` is an unmodified render of the original SVG;
`person_goal.png` is a combination of `person.png` and `goal.png` (and
thus licensed under AGPLv3+).

<!-- vim: set tw=70 sw=2 sts=2 et fdm=marker : -->
