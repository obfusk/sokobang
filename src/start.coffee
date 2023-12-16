# <!-- {{{1 -->
#
#     File        : start.coffee
#     Maintainer  : FC Stegerman <flx@obfusk.net>
#     Date        : 2020-09-08
#
#     Copyright   : Copyright (C) 2020  FC Stegerman
#     Version     : v0.2.1
#     Licence     : AGPLv3+
#
# <!-- }}}1 -->

$ ->
  $sets   = $ '#sets'   ; $levels = $ '#levels'; $play = $ '#play'
  $next   = $ '#next'   ; $canvas = $ '#CANVAS'; $game = $ '#game'
  $set    = $ '#set'    ; $level  = $ '#level'
  $moves  = $ '#moves'  ; $pushes = $ '#pushes'
  levels  = quit = done = null; current = set: 3, level: 0

  completed_level = (c = current) ->
    localStorage.setItem "level #{c.set} #{c.level}", "done"
    e = $levels.children()[c.level]
    $(e).text (i, t) -> if t.endsWith("✓") then t else t + " ✓"

  level_completed = (c = current) ->
    localStorage.getItem("level #{c.set} #{c.level}") == "done"

  scroll = ->
    x = ($canvas.width()  - $game.width() ) / 2
    y = ($canvas.height() - $game.height()) / 2
    $game.scrollLeft(x).scrollTop(y)
    $('#data-and-buttons')[0].scrollIntoView false

  get_lvl = ->
    parseInt x for x in (if /^\d+_\d+$/.test h = location.hash.slice 1
    then h else localStorage.getItem("level") || "3_0").split "_"
  set_lvl = ->
    localStorage.setItem "level",
      location.hash = "#{current.set}_#{current.level}"

  on_done = (w) ->
    completed_level() unless w.quit
    quit = null; done?()

  on_update = (m, p) -> $moves.text m; $pushes.text p

  oops = -> _alert 'We apologise for the inconvenience...'
  opts = { canvas: $canvas[0], on_done, on_update }

  for x in 'goal person person_goal object object_goal wall'.split(/\ +/)
    opts["#{x}_img"] = $("##{x}_img")[0]

  start = (level) ->
    $canvas.focus(); done = null; quit = sokobang.start opts, level

  play = (set, level) ->
    $play.prop 'disabled', true; current = {set,level}; set_lvl()
    $('#completed')[if level_completed() then "show" else "hide"]()
    $set.text levels[set].name; $level.text level + 1; on_update 0, 0
    done = ->
      $.get "levels/level_#{set}_#{level}.json"
        .done (data) -> $play.prop 'disabled', false; start data
        .fail oops
    if quit then quit() else done()
    setTimeout scroll, 500                                      # TODO

  next_level = ->
    s = current.set; l = current.level
    if l < levels[s].levels - 1
      $sets.val s; $levels.val l + 1
    else
      if s < levels.length - 1
        $sets.val s + 1; set_levels()
      else
        _alert 'There are no more levels.'
    $play.click()

  set_levels = ->
    n = parseInt $sets.val(); $levels.empty()
    for i in [0 .. levels[n].levels - 1]
      t = i + 1; t += " ✓" if level_completed set: n, level: i
      $levels.append $('<option>').val(i).text t
    null

  kc    = bigbang.keycodes
  btns  =
    left: kc.LEFT, down: kc.DOWN, up: kc.UP, right: kc.RIGHT,
    undo: 'U'.charCodeAt()

  for k, v of btns
    do (k, v) -> $("##{k}").on 'click', ->
      $canvas.trigger $.Event 'keydown', which: v

  $('body').on 'keydown', (e) ->
    $canvas.trigger e if Object.values(btns).includes e.which

  $('#zoom').change ->
    $canvas.toggleClass "zoom", this.checked
    setTimeout scroll, 500                                      # TODO

  $.get 'levels/levels.json'
    .done (data) ->
      levels = data
      $sets.append $('<option>').val(i).text(x.name) for x, i in levels
      $sets.change set_levels
      $play.click -> play parseInt($sets.val()), parseInt($levels.val())
      $next.click next_level
      $canvas.attr 'tabindex', 0
      [set, lvl] = get_lvl(); current = {set, lvl}
      $sets.val set; set_levels(); $levels.val lvl; $play.click()
    .fail oops

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
