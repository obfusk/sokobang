// Generated by CoffeeScript 1.12.8
(function() {
  var B, S, U, data_to_world, defaults, goals_reached, img_and_scene, img_list_and_scene, is_dir, move, move_person, move_person_click, place_goals, place_objects, place_person, place_walls, posn_str, posn_to_canvas_xy, posn_to_canvas_xy_scaled, render_end, render_world, sorted_positions, start, update_world,
    slice = [].slice;

  U = this._ || require('underscore');

  B = this.bigbang || require('bigbang');

  S = typeof exports !== "undefined" && exports !== null ? exports : this.sokobang || (this.sokobang = {});

  S.defaults = defaults = {
    endgame_text_size: '3em',
    img_size: 48,
    you_won: 'You did it!'
  };

  S.start = start = function(opts, level) {
    var $, bb_opts, draw, o, on_quit, quit, setup, teardown, w;
    o = U.extend({}, defaults, opts);
    o.width_px = o.img_size * level.width;
    o.height_px = o.img_size * level.height;
    o.width_px_half = Math.round(o.width_px / 2);
    o.height_px_half = Math.round(o.height_px / 2);
    o.bg_scene = B.empty_scene(o.width_px, o.height_px);
    w = data_to_world(level, o);
    $ = opts.$ || window.$;
    on_quit = function(w) {
      return B.stop_with(update_world(w, {
        quit: true
      }));
    };
    quit = function() {
      $(opts.canvas).trigger($.Event('bb_quit'));
      return null;
    };
    draw = function(w) {
      opts.on_update(w.moves, w.pushes);
      return render_world(w);
    };
    setup = function(c, hs) {
      var h_quit;
      h_quit = (function(e) {
        return hs.quit();
      });
      $(c).on('bb_quit', h_quit);
      return {
        h_quit: h_quit
      };
    };
    teardown = function(c, hs, sv) {
      return $(c).off('bb_quit', sv.h_quit);
    };
    bb_opts = {
      canvas: opts.canvas,
      world: w,
      on_key: move_person,
      on_click: move_person_click,
      stop_when: goals_reached,
      to_draw: draw,
      last_draw: render_end,
      on_stop: opts.on_done,
      on: {
        quit: on_quit
      },
      setup: setup,
      teardown: teardown
    };
    B(bb_opts);
    return quit;
  };

  S.data_to_world = data_to_world = function(data, opts) {
    var cell, g, goals, i, j, l, len, len1, len2, len3, len4, m, meta, n, o, objects, person, posn, q, r, ref, row, w, walls;
    objects = [];
    goals = [];
    walls = [];
    person = null;
    meta = {
      objects: {},
      goals: {},
      walls: {}
    };
    ref = data.data;
    for (i = l = 0, len = ref.length; l < len; i = ++l) {
      row = ref[i];
      for (j = m = 0, len1 = row.length; m < len1; j = ++m) {
        cell = row[j];
        posn = {
          x: j,
          y: i
        };
        switch (cell) {
          case '@':
            person = posn;
            break;
          case '#':
            walls.push(posn);
            break;
          case '$':
            objects.push(posn);
            break;
          case '.':
            goals.push(posn);
            break;
          case '*':
            goals.push(posn);
            objects.push(posn);
            break;
          case '+':
            goals.push(posn);
            person = posn;
        }
      }
    }
    for (n = 0, len2 = objects.length; n < len2; n++) {
      o = objects[n];
      meta.objects[posn_str(o)] = o;
    }
    for (q = 0, len3 = goals.length; q < len3; q++) {
      g = goals[q];
      meta.goals[posn_str(g)] = g;
    }
    for (r = 0, len4 = walls.length; r < len4; r++) {
      w = walls[r];
      meta.walls[posn_str(w)] = w;
    }
    return {
      h: data.height,
      w: data.width,
      person: person,
      objects: objects,
      goals: goals,
      walls: walls,
      meta: meta,
      opts: opts,
      prev: null,
      moves: 0,
      pushes: 0
    };
  };

  S.update_world = update_world = function(w, w_) {
    var l, len, o, ref, w2;
    w2 = U.extend({}, w, w_);
    if (w_.objects) {
      w2.meta = U.extend({}, w2.meta, {
        objects: {}
      });
      ref = w2.objects;
      for (l = 0, len = ref.length; l < len; l++) {
        o = ref[l];
        w2.meta.objects[posn_str(o)] = o;
      }
    }
    return w2;
  };

  S.move_person = move_person = function(w, k) {
    var move_posn, o, objs_, push_posn, w_;
    if (k === 'u') {
      return w.prev || w;
    }
    if (!is_dir(k)) {
      return w;
    }
    move_posn = move(w.person, k);
    if (w.meta.walls[posn_str(move_posn)]) {
      return w;
    }
    w_ = update_world(w, {
      person: move_posn,
      prev: w,
      moves: w.moves + 1
    });
    if (!w.meta.objects[posn_str(move_posn)]) {
      return w_;
    }
    push_posn = move(move_posn, k);
    if (w.meta.walls[posn_str(push_posn)] || w.meta.objects[posn_str(push_posn)]) {
      return w;
    }
    objs_ = (function() {
      var l, len, ref, results;
      ref = w.objects;
      results = [];
      for (l = 0, len = ref.length; l < len; l++) {
        o = ref[l];
        if (U.isEqual(o, move_posn)) {
          results.push(push_posn);
        } else {
          results.push(o);
        }
      }
      return results;
    })();
    return update_world(w_, {
      objects: objs_,
      pushes: w.pushes + 1
    });
  };

  S.move_person_click = move_person_click = function(w, x, y) {
    var dx, dy, person_x, person_y, ref, ref1;
    ref = posn_to_canvas_xy_scaled(w.person, w.opts), person_x = ref[0], person_y = ref[1];
    ref1 = [x - person_x, y - person_y], dx = ref1[0], dy = ref1[1];
    return move_person(w, Math.abs(dx) > Math.abs(dy) ? dx < 0 ? 'left' : 'right' : dy < 0 ? 'up' : 'down');
  };

  S.goals_reached = goals_reached = function(w) {
    return U.isEqual(sorted_positions(w.objects), sorted_positions(w.goals));
  };

  S.render_world = render_world = function(w) {
    return place_person(w, place_objects(w, place_goals(w, place_walls(w, w.opts.bg_scene))));
  };

  S.render_end = render_end = function(w) {
    if (w.quit) {
      return render_world(w);
    }
    return B.place_text(w.opts.you_won, w.opts.width_px_half, w.opts.height_px_half, w.opts.endgame_text_size, 'red', render_world(w));
  };

  S.place_person = place_person = function(w, scene) {
    var img;
    img = w.meta.goals[posn_str(w.person)] ? w.opts.person_goal_img : w.opts.person_img;
    return img_and_scene(w.person, img, w.opts, scene);
  };

  S.place_objects = place_objects = function(w, scene) {
    var obj_goals, objs, ref;
    ref = U.partition(w.objects, function(o) {
      return w.meta.goals[posn_str(o)];
    }), obj_goals = ref[0], objs = ref[1];
    return img_list_and_scene(objs, w.opts.object_img, w.opts, img_list_and_scene(obj_goals, w.opts.object_goal_img, w.opts, scene));
  };

  S.place_goals = place_goals = function(w, scene) {
    return img_list_and_scene(w.goals, w.opts.goal_img, w.opts, scene);
  };

  S.place_walls = place_walls = function(w, scene) {
    return img_list_and_scene(w.walls, w.opts.wall_img, w.opts, scene);
  };

  S.img_list_and_scene = img_list_and_scene = function(posns, img, opts, scene) {
    var f;
    f = function(s, p) {
      return img_and_scene(p, img, opts, s);
    };
    return U.reduce(posns, f, scene);
  };

  S.img_and_scene = img_and_scene = function(posn, img, opts, scene) {
    return B.place_image.apply(B, [img].concat(slice.call(posn_to_canvas_xy(posn, opts)), [scene]));
  };

  S.posn_to_canvas_xy = posn_to_canvas_xy = function(posn, opts) {
    return [posn.x * opts.img_size + opts.img_size / 2, posn.y * opts.img_size + opts.img_size / 2];
  };

  S.posn_to_canvas_xy_scaled = posn_to_canvas_xy_scaled = function(posn, opts) {
    var ref, x, y;
    ref = posn_to_canvas_xy(posn, opts), x = ref[0], y = ref[1];
    return [x * opts.canvas.clientWidth / opts.canvas.width, y * opts.canvas.clientHeight / opts.canvas.height];
  };

  S.is_dir = is_dir = function(x) {
    return x === 'up' || x === 'down' || x === 'left' || x === 'right';
  };

  S.move = move = function(posn, d) {
    switch (d) {
      case 'up':
        return U.extend({}, posn, {
          y: posn.y - 1
        });
      case 'down':
        return U.extend({}, posn, {
          y: posn.y + 1
        });
      case 'left':
        return U.extend({}, posn, {
          x: posn.x - 1
        });
      case 'right':
        return U.extend({}, posn, {
          x: posn.x + 1
        });
    }
  };

  S.posn_str = posn_str = function(posn) {
    return posn.x + "," + posn.y;
  };

  S.sorted_positions = sorted_positions = function(xs) {
    return U.sortBy(xs, function(x) {
      return [x.x, x.y];
    });
  };

}).call(this);
