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

S.defaults = defaults =
  endgame_text_size: '5em', img_size: 48, you_won: 'You did it!'

# --

S.start = start = (opts, level) ->                              # {{{1
  o                 = U.extend {}, defaults, opts
  o.width_px        = o.img_size * level.width
  o.height_px       = o.img_size * level.height
  o.width_px_half   = Math.round o.width_px  / 2
  o.height_px_half  = Math.round o.height_px / 2
  o.bg_scene        = B.empty_scene o.width_px, o.height_px
  w                 = data_to_world level, o

  bb_opts =
    canvas: opts.canvas, world: w, on_key: move_man,
    stop_when: goals_reached, to_draw: render_world,
    last_draw: render_end, on_stop: opts.done
  B bb_opts
                                                                # }}}1

# --

S.data_to_world = data_to_world = (data, opts) ->               # {{{1
  objects = []; goals = []; walls = []; man = null
  for row, i in data.data
    for cell, j in row
      posn = x: j, y: i
      switch cell
        when '@' then man =         posn
        when '#' then walls.push    posn
        when '$' then objects.push  posn
        when '.' then goals.push    posn
        when '*' then objects.push  posn; goals.push  posn
        when '+' then objects.push  posn; man =       posn
  mk_world data.height, data.width, man, objects, goals, walls, opts
                                                                # }}}1

S.mk_world = mk_world = (h, w, man, objects, goals, walls, opts) ->
  {h,w,man,objects,goals,walls,opts}

# --

S.move_man = move_man = (w, k) ->
  return w unless is_dir k
  move_posn = move w.man, k
  return w if one_of w.walls, move_posn
  w_ = U.extend {}, w, man: move_posn
  return w_ unless one_of w.objects, move_posn
  push_posn = move move_posn, k
  return w if one_of w.walls, push_posn || one_of w.objects, push_posn
  objs_ = for o in w.objects
    if U.isEqual o, move_posn then push_posn else o
  U.extend {}, w_, objects: objs_

S.goals_reached = goals_reached = (w) ->
  U.isEqual sorted_positions(w.objects), sorted_positions(w.goals)

# --

S.render_world = render_world = (w) ->
  place_man w, place_objects w, place_goals w, place_walls w, w.opts.bg_scene

S.render_end = render_end = (w) ->
  B.place_text w.opts.you_won, w.opts.width_px_half,
    w.opts.height_px_half, w.opts.endgame_text_size, 'black',
    render_world(w)

# --

S.place_man = place_man = (w, scene) ->
  img = if one_of w.goals, w.man then w.opts.man_goal_img else w.opts.man_img
  img_and_scene w.man, img, w.opts, scene

S.place_objects = place_objects = (w, scene) ->
  overlap = for p in w.objects
    U.filter w.goals, (q) -> U.isEqual p, q
  objects = U.reject w.objects, (p, i) ->
    U.isEqual(p, w.man) || overlap[i].length
  img_list_and_scene objects, w.opts.object_img, w.opts,
    img_list_and_scene(U.flatten(overlap, true), w.opts.object_goal_img,
                       w.opts, scene)

S.place_goals = place_goals = (w, scene) ->
  goals = U.reject w.goals, (p) -> U.isEqual(p, w.man) || one_of w.objects, p
  img_list_and_scene goals, w.opts.goal_img, w.opts, scene

S.place_walls = place_walls = (w, scene) ->
  img_list_and_scene w.walls, w.opts.wall_img, w.opts, scene

# --

S.img_list_and_scene = img_list_and_scene = (posns, img, opts, scene) ->
  f = (s, p) -> img_and_scene p, img, opts, s
  U.reduce posns, f, scene

S.img_and_scene = img_and_scene = (posn, img, opts, scene) ->
  B.place_image img,
    (posn.x * opts.img_size + opts.img_size/2),
    (posn.y * opts.img_size + opts.img_size/2), scene

# --

S.is_dir = is_dir = (x) ->
  x == 'up' || x == 'down' || x == 'left' || x == 'right'

S.move = move = (posn, d) ->
  switch d
    when 'up'     then U.extend {}, posn, y: posn.y - 1
    when 'down'   then U.extend {}, posn, y: posn.y + 1
    when 'left'   then U.extend {}, posn, x: posn.x - 1
    when 'right'  then U.extend {}, posn, x: posn.x + 1

S.one_of = one_of = (xs, x) -> U.some xs, (y) -> U.isEqual x, y

S.sorted_positions = sorted_positions = (xs) ->
  U.sortBy xs, (x) -> [x.x,x.y]

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
