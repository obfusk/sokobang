# <!-- {{{1 -->
#
#     File        : start.coffee
#     Maintainer  : Felix C. Stegerman <flx@obfusk.net>
#     Date        : 2014-07-17
#
#     Copyright   : Copyright (C) 2014  Felix C. Stegerman
#     Licence     : AGPLv3+
#
# <!-- }}}1 -->

$ ->
  $sets   = $ '#sets'   ; $levels = $ '#levels'; $play = $ '#play'
  $next   = $ '#next'   ; $canvas = $ '#CANVAS'
  $set    = $ '#set'    ; $level  = $ '#level'
  $moves  = $ '#moves'  ; $pushes = $ '#pushes'
  levels  = quit = done = null; current = set: 0, level: 0

  on_done   = -> quit = null; done?()
  on_update = (m, p) -> $moves.text m; $pushes.text p

  oops    = -> alert 'We apologise for the inconvenience...'
  opts    = { canvas: $canvas[0], on_done, on_update }

  for x in 'goal man man_goal object object_goal wall'.split(/\ +/)
    opts["#{x}_img"] = $("##{x}_img")[0]

  start = (level) ->
    $canvas.focus(); done = null; quit = sokobang.start opts, level

  play = (set, level) ->
    $play.prop 'disabled', true; current = {set,level}
    $set.text levels[set].name; $level.text level + 1; on_update 0, 0
    done = ->
      $.get "/levels/level_#{set}_#{level}.json"
        .done (data) -> $play.prop 'disabled', false; start data
        .fail oops
    if quit then quit() else done()

  next_level = ->
    s = current.set; l = current.level
    if l < levels[s].levels - 1
      $levels.val l + 1
    else
      if s < levels.length - 1
        $sets.val s + 1; set_levels()
      else
        alert 'There are no more levels.'
    $play.click()

  set_levels = ->
    n = parseInt $sets.val(); $levels.empty()
    for i in [0 .. levels[n].levels - 1]
      $levels.append $('<option>').val(i).text i + 1
    null

  $.get '/levels/levels.json'
    .done (data) ->
      levels = data
      $sets.append $('<option>').val(i).text(x.name) for x, i in levels
      $sets.change set_levels
      $play.click -> play parseInt($sets.val()), parseInt($levels.val())
      $next.click next_level
      $canvas.attr 'tabindex', 0
      set_levels(); $play.click()
    .fail oops

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
