# <!-- {{{1 -->
#
#     File        : sokobang.coffee
#     Maintainer  : FC Stegerman <flx@obfusk.net>
#     Date        : 2020-09-08
#
#     Copyright   : Copyright (C) 2020  FC Stegerman
#     Version     : v0.2.1
#     Licence     : AGPLv3+
#
# <!-- }}}1 -->

U = this._        || require 'underscore'
B = this.bigbang  || require 'bigbang'
S = exports ? this.sokobang ||= {}

# --

S.defaults = defaults =
  endgame_text_size: '3em', img_size: 48, you_won: 'You did it!'

# --

S.start = start = (opts, level) ->                              # {{{1
  o                 = U.extend {}, defaults, opts
  o.width_px        = o.img_size * level.width
  o.height_px       = o.img_size * level.height
  o.width_px_half   = Math.round o.width_px  / 2
  o.height_px_half  = Math.round o.height_px / 2
  o.bg_scene        = B.empty_scene o.width_px, o.height_px
  w                 = data_to_world level, o
  $                 = opts.$ || window.$

  on_quit = (w) -> B.stop_with update_world w, quit: true
  quit    = -> $(opts.canvas).trigger $.Event 'bb_quit'; null
  draw    = (w) -> opts.on_update w.moves, w.pushes; render_world w

  setup = (c, hs) ->
    h_quit = ((e) -> hs.quit()); $(c).on 'bb_quit', h_quit; {h_quit}

  teardown = (c, hs, sv) -> $(c).off 'bb_quit', sv.h_quit

  bb_opts =
    canvas: opts.canvas, world: w, on_key: move_person,
    on_click: move_person_click, stop_when: goals_reached,
    to_draw: draw, last_draw: render_end, on_stop: opts.on_done,
    on: { quit: on_quit }, setup: setup, teardown: teardown,
    # queue: 1, on_tick: true

  B bb_opts
  quit
                                                                # }}}1

# --

S.data_to_world = data_to_world = (data, opts) ->               # {{{1
  objects = []; goals = []; walls = []; person = null
  meta = objects: {}, goals: {}, walls: {}
  for row, i in data.data
    for cell, j in row
      posn = x: j, y: i
      switch cell
        when '@' then person =      posn
        when '#' then walls.push    posn
        when '$' then objects.push  posn
        when '.' then goals.push    posn
        when '*' then goals.push    posn; objects.push  posn
        when '+' then goals.push    posn; person =      posn
  for o in objects
    meta.objects[posn_str o] = o
  for g in goals
    meta.goals[posn_str g] = g
  for w in walls
    meta.walls[posn_str w] = w
  { h: data.height, w: data.width, person, objects, goals, walls, \
    meta, opts, prev: null, moves: 0, pushes: 0 }
                                                                # }}}1

S.update_world = update_world = (w, w_) ->
  w2 = U.extend {}, w, w_
  if w_.objects
    w2.meta = U.extend {}, w2.meta, objects: {}
    for o in w2.objects
      w2.meta.objects[posn_str o] = o
  w2

# --

S.move_person = move_person = (w, k) ->                         # {{{1
  return w.prev || w if k == 'u'  # undo
  return w unless is_dir k
  move_posn = move w.person, k
  return w if w.meta.walls[posn_str move_posn]
  w_ = update_world w, person: move_posn, prev: w, moves: w.moves + 1
  return w_ unless w.meta.objects[posn_str move_posn]
  push_posn = move move_posn, k
  return w if w.meta.  walls[posn_str push_posn] ||
              w.meta.objects[posn_str push_posn]
  objs_ = for o in w.objects
    if U.isEqual o, move_posn then push_posn else o
  update_world w_, objects: objs_, pushes: w.pushes + 1
                                                                # }}}1

S.move_person_click = move_person_click = (w, x, y) ->
  [person_x, person_y]  = posn_to_canvas_xy_scaled w.person, w.opts
  [dx, dy]              = [x - person_x, y - person_y]
  move_person w, if Math.abs(dx) > Math.abs(dy)
    if dx < 0 then 'left' else 'right'
  else
    if dy < 0 then 'up' else 'down'

S.goals_reached = goals_reached = (w) ->
  U.isEqual sorted_positions(w.objects), sorted_positions(w.goals)

# --

S.render_world = render_world = (w) ->
  place_person w, place_objects w, place_goals w, place_walls w,
    w.opts.bg_scene
  # NB: place person over goals!

S.render_end = render_end = (w) ->
  return render_world w if w.quit
  B.place_text w.opts.you_won, w.opts.width_px_half,
    w.opts.height_px_half, w.opts.endgame_text_size, 'red',
    render_world(w)

# --

S.place_person = place_person = (w, scene) ->
  img = if w.meta.goals[posn_str w.person]
    w.opts.person_goal_img
  else
    w.opts.person_img
  img_and_scene w.person, img, w.opts, scene

S.place_objects = place_objects = (w, scene) ->
  [obj_goals,objs] = U.partition w.objects, (o) -> w.meta.goals[posn_str o]
  img_list_and_scene objs, w.opts.object_img, w.opts,
    img_list_and_scene(obj_goals, w.opts.object_goal_img, w.opts, scene)

S.place_goals = place_goals = (w, scene) ->
  img_list_and_scene w.goals, w.opts.goal_img, w.opts, scene

S.place_walls = place_walls = (w, scene) ->
  img_list_and_scene w.walls, w.opts.wall_img, w.opts, scene

# --

S.img_list_and_scene = img_list_and_scene = (posns, img, opts, scene) ->
  f = (s, p) -> img_and_scene p, img, opts, s
  U.reduce posns, f, scene

S.img_and_scene = img_and_scene = (posn, img, opts, scene) ->
  B.place_image img, posn_to_canvas_xy(posn, opts)..., scene

S.posn_to_canvas_xy = posn_to_canvas_xy = (posn, opts) ->
  [posn.x * opts.img_size + opts.img_size/2,
   posn.y * opts.img_size + opts.img_size/2]

S.posn_to_canvas_xy_scaled = posn_to_canvas_xy_scaled = (posn, opts) ->
  [x, y] = posn_to_canvas_xy posn, opts
  [x * opts.canvas.clientWidth  / opts.canvas.width,
   y * opts.canvas.clientHeight / opts.canvas.height]

# --

S.is_dir = is_dir = (x) ->
  x == 'up' || x == 'down' || x == 'left' || x == 'right'

S.move = move = (posn, d) ->
  switch d
    when 'up'     then U.extend {}, posn, y: posn.y - 1
    when 'down'   then U.extend {}, posn, y: posn.y + 1
    when 'left'   then U.extend {}, posn, x: posn.x - 1
    when 'right'  then U.extend {}, posn, x: posn.x + 1

S.posn_str = posn_str = (posn) -> "#{posn.x},#{posn.y}"

S.sorted_positions = sorted_positions = (xs) ->
  U.sortBy xs, (x) -> [x.x,x.y]

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
