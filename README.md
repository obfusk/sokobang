
    File        : README.md
    Maintainer  : Felix C. Stegerman <flx@obfusk.net>
    Date        : 2014-07-18

    Copyright   : Copyright (C) 2014  Felix C. Stegerman
    Version     : v0.1.2

## Description

  sokobang - sokoban puzzle w/ bigbang.coffee

  A sokoban puzzle -- with images and levels from ksokoban [1] --
  written in coffeescript using the bigbang.coffee [2] library.

  To run the game, you will need bigbang.coffee; when using git, use
  `git submodule update --init` to fetch and use the dependencies.

## Specs & Docs

```bash
$ rake spec   # TODO
$ rake docs
```

## TODO

  * further optimize drawing?
  * reload level?
  * improve render_end?
  * improve state handling in start.coffee?
  * specs/docs?
  * ...

## License

  AGPLv3+ [3].

## References

  [1] ksokoban
  --- https://projects.kde.org/projects/playground/games/ksokoban/repository

  [2] bigbang.coffee
  --- https://github.com/obfusk/bigbang.coffee

  [3] GNU Affero General Public License, version 3
  --- http://www.gnu.org/licenses/agpl-3.0.html

<!-- vim: set tw=70 sw=2 sts=2 et fdm=marker : -->
