[]: {{{1

    File        : README.md
    Maintainer  : Felix C. Stegerman <flx@obfusk.net>
    Date        : 2014-07-16

    Copyright   : Copyright (C) 2014  Felix C. Stegerman
    Version     : v0.0.1

[]: }}}1

## Description
[]: {{{1

  sokobang - sokoban puzzle w/ bigbang.coffee

  A sokoban puzzle (with images and levels from ksokoban [1]) written
  in coffeescript using the bigbang.coffee [2] library.

  To run the game, you will need bigbang.coffee; when using git, use
  `git submodule update --init` to fetch and use these dependencies.

[]: }}}1

## Specs & Docs
[]: {{{1

    $ rake spec
    $ rake docs

[]: }}}1

## TODO
[]: {{{1

  * cancel level / choose another
  * undo
  * background images
  * show level, #steps, #pushes, etc.
  * improve render_end
  * tell user how to play
  * specs/docs?
  * ...

[]: }}}1

## License
[]: {{{1

  GPLv3+ [3].

[]: }}}1

## References
[]: {{{1

  [1] ksokoban
  --- https://projects.kde.org/projects/playground/games/ksokoban/repository

  [2] bigbang.coffee
  --- https://github.com/obfusk/bigbang.coffee

  [3] GNU General Public License, version 3
  --- http://www.gnu.org/licenses/gpl-3.0.html

[]: }}}1

[]: ! ( vim: set tw=70 sw=2 sts=2 et fdm=marker : )
