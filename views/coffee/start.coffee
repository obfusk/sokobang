# <!-- {{{1 -->
#
#     File        : start.coffee
#     Maintainer  : Felix C. Stegerman <flx@obfusk.net>
#     Date        : 2014-07-16
#
#     Copyright   : Copyright (C) 2014  Felix C. Stegerman
#     Licence     : GPLv3+
#
# <!-- }}}1 -->

$ ->
  $sets   = $ '#sets'   ; $levels = $ '#levels' ; $play = $ '#play'
  $canvas = $ '#CANVAS' ; levels  = null

  oops = -> alert 'We apologise for the inconvenience...'
  done = -> $play.prop 'disabled', false
  opts = canvas: $canvas[0], done: done

  for x in 'goal man man_goal object object_goal wall'.split(/\ +/)
    opts["#{x}_img"] = $("##{x}_img")[0]

  start = (level) ->
    $canvas.focus(); sokobang.start opts, level

  play = (set, level) ->
    $play.prop 'disabled', true
    $.get "/levels/level_#{set}_#{level}.json"
      .done (data) -> start data
      .fail oops

  set_levels = ->
    n = parseInt $sets.val(); $levels.empty()
    for i in [0..levels[n].levels-1]
      $levels.append $('<option>').val(i).text i+1

  $sets.change set_levels
  $play.click -> play $sets.val(), $levels.val()
  $canvas.attr 'tabindex', 0

  $.get '/levels/levels.json'
    .done (data) ->
      levels = data
      $sets.append $('<option>').val(i).text(x.name) for x, i in levels
      set_levels(); $play.click()
    .fail oops

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
