[app]
title = Sokoban(g)
package.name = sokobang
package.domain = dev.obfusk
source.dir = .
source.exclude_dirs = badges,bin,deps,fastlane,icon,patches,p4a-recipes,scripts,spec,src,templates
source.exclude_patterns = makefile,p4a-commit,screenshot.png,static.json
requirements =
  click==7.1.2,flask==1.1.2,openssl,sqlite3,
  hostpython3==3.9.2,python3==3.9.2,
  android,genericndkbuild,
  itsdangerous==1.1.0,jinja2==2.11.3,markupsafe==1.1.1,werkzeug==1.0.1,
  libffi==v3.3,pyjnius==1.3.0,
  setuptools==53.0.0,six==1.15.0
icon.filename = %(source.dir)s/icon.png
orientation = portrait
fullscreen = 0
android.api = 30
android.minapi = 23
android.ndk = 22
#android.ndk_path =
#android.sdk_path =
android.accept_sdk_license = True
android.arch = arm64-v8a
p4a.branch = develop
#p4a.source_dir =
p4a.local_recipes = ./p4a-recipes
p4a.bootstrap = webview
p4a.port = 24235

# === DON'T FORGET TO UPDATE THIS ===
version = 0.2.3
android.numeric_version = 1000203002
# always "1" -------------^|||||||||
# 0.2.3 ----> 00 02 03 ----^^^^^^|||
# #commits since last tag -------^^|
# 1 = armeabi-v7a, 2 = arm64-v8a --^
# ===================================

[buildozer]
log_level = 2
warn_on_root = 1
