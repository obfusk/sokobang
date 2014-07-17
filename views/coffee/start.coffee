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
  $sets   = $ '#sets'   ; $levels = $ '#levels'; $play = $ '#play'
  $canvas = $ '#CANVAS' ; levels  = quit = done = null

  on_done = -> quit = null; done?()
  oops    = -> alert 'We apologise for the inconvenience...'
  opts    = canvas: $canvas[0], on_done: on_done

  for x in 'goal man man_goal object object_goal wall'.split(/\ +/)
    opts["#{x}_img"] = $("##{x}_img")[0]

  start = (level) ->
    $canvas.focus(); done = null; quit = sokobang.start opts, level

  play = (set, level) ->
    $play.prop 'disabled', true
    done = ->
      $.get "/levels/level_#{set}_#{level}.json"
        .done (data) -> $play.prop 'disabled', false; start data
        .fail oops
    if quit then quit() else done()

  set_levels = ->
    n = parseInt $sets.val(); $levels.empty()
    for i in [0..levels[n].levels-1]
      $levels.append $('<option>').val(i).text i+1
    null

  $.get '/levels/levels.json'
    .done (data) ->
      levels = data
      $sets.append $('<option>').val(i).text(x.name) for x, i in levels
      $sets.change set_levels
      $play.click -> play $sets.val(), $levels.val()
      $canvas.attr 'tabindex', 0
      set_levels(); $play.click()
    .fail oops

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
