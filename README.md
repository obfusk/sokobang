<!-- {{{1

    File        : README.md
    Maintainer  : FC Stegerman <flx@obfusk.net>
    Date        : 2021-07-12

    Copyright   : Copyright (C) 2021  FC Stegerman
    Version     : v0.2.5
    License     : AGPLv3+

}}}1 -->

[![GitHub Release](https://img.shields.io/github/release/obfusk/sokobang.svg?logo=github)](https://github.com/obfusk/sokobang/releases)
[![F-Droid Version](https://img.shields.io/f-droid/v/dev.obfusk.sokobang.svg)](https://f-droid.org/app/dev.obfusk.sokobang)
[![Android Build](https://github.com/obfusk/sokobang/workflows/Android/badge.svg)](https://github.com/obfusk/sokobang/actions?query=workflow%3AAndroid)
[![AGPLv3+](https://img.shields.io/badge/license-AGPLv3+-blue.svg)](https://www.gnu.org/licenses/agpl-3.0.html)
[![Sponsor](https://img.shields.io/badge/%E2%99%A5-support-violet.svg)](https://ko-fi.com/obfusk)

## Description

sokobang - sokoban puzzle w/ bigbang.coffee

→ https://sokobang.obfusk.dev

[<img src="badges/faysrepo.png" alt="Get it from Fay's Repo" height="60">](https://obfusk.dev/fdroid/repo?fingerprint=2A21B7FFC93B878724B1991C05DAE113C72B93A556C193F49B5D3342884798B7)
[<img src="badges/fdroid.png" alt="Get it on F-Droid" height="60">](https://f-droid.org/app/dev.obfusk.sokobang)
[<img src="badges/github.png" alt="Get the APK from GitHub" height="60">](https://github.com/obfusk/sokobang/releases/latest)

Sokoban(g) is a sokoban puzzle -- with images and levels from
[ksokoban](https://projects.kde.org/projects/playground/games/ksokoban/repository)
-- written in coffeescript using the
[bigbang.coffee](https://github.com/obfusk/bigbang.coffee) library.

![screenshot](screenshot.png)

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

© FC Stegerman

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
