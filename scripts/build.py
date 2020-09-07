#!/usr/bin/env python3

import time
from pathlib import Path
from jinja2 import Environment, FileSystemLoader, select_autoescape

DEPENDENCIES = dict(                                            # {{{1
  p4a = dict(
    name  = "python-for-android",
    url   = "https://github.com/kivy/python-for-android"
  ),

  libffi        = dict(url = "https://github.com/libffi/libffi"),
  openssl       = dict(url = "https://www.openssl.org"),
  pyjnius       = dict(url = "https://github.com/kivy/pyjnius"),
  python3       = dict(url = "https://www.python.org"),
  sqlite3       = dict(url = "https://www.sqlite.org"),

  click         = dict(url = "https://github.com/pallets/click"),
  flask         = dict(url = "https://github.com/pallets/flask"),
  itsdangerous  = dict(url = "https://github.com/pallets/itsdangerous"),
  jinja2        = dict(url = "https://github.com/pallets/jinja"),
  markupsafe    = dict(url = "https://github.com/pallets/markupsafe"),
  setuptools    = dict(url = "https://github.com/pypa/setuptools"),
  six           = dict(url = "https://github.com/benjaminp/six"),
  werkzeug      = dict(url = "https://github.com/pallets/werkzeug"),

  noto_emoji = dict(
    name  = "noto-emoji",
    url   = "https://github.com/googlefonts/noto-emoji"
  ),
)                                                               # }}}1

data  = dict(DEPS = DEPENDENCIES, now = time.time())
env   = Environment(loader      = FileSystemLoader("templates"),
                    autoescape  = select_autoescape())

for t in "index".split():
  print("building {}.html ...".format(t))
  tmpl  = env.get_template(t + ".html")
  out   = Path("public/{}.html".format(t))
  with out.open("w") as f:
    tmpl.stream(page = t, **data).dump(f); f.write("\n")
