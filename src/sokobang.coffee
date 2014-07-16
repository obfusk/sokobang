# <!-- {{{1 -->
#
#     File        : sokobang.coffee
#     Maintainer  : Felix C. Stegerman <flx@obfusk.net>
#     Date        : 2014-07-16
#
#     Copyright   : Copyright (C) 2014  Felix C. Stegerman
#     Licence     : GPLv3+
#
# <!-- }}}1 -->

U = this._        || require 'underscore'
B = this.bigbang  || require 'bigbang'
S = exports ? this.sokobang ||= {}

# --

S.start = start = (opts) ->
  console.log 'start!', opts

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
