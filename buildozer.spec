[app]
title = Sokoban(g)
package.name = sokobang
package.domain = dev.obfusk
source.dir = .
source.exclude_dirs = badges,bin,deps,fastlane,icon,patches,p4a-recipes,scripts,spec,src,templates
source.exclude_patterns = buildozer.spec,local.properties,makefile,p4a-commit,screenshot.png,static.json
requirements =
  click==8.0.1,flask==2.0.1,openssl,sqlite3,
  hostpython3==3.9.6,python3==3.9.6,
  android,genericndkbuild,
  itsdangerous==2.0.1,jinja2==3.0.1,markupsafe==2.0.1,werkzeug==2.0.1,
  libffi==v3.4.2,pyjnius==1.3.0,
  setuptools==57.1.0,six==1.16.0
icon.filename = %(source.dir)s/icon.png
orientation = portrait
fullscreen = 0
android.api = 30
android.minapi = 23

# https://gitlab.com/fdroid/android-sdk-transparency-log/-/raw/master/checksums.json
android.ndk = 22b
android.ndk_path = /opt/android-sdk/ndk/22.1.7171670

#android.sdk_path =
android.accept_sdk_license = True
android.arch = arm64-v8a
p4a.branch = develop
#p4a.source_dir =
p4a.local_recipes = ./p4a-recipes
p4a.bootstrap = webview
p4a.port = 24235

# === DON'T FORGET TO UPDATE THIS ===
version = 0.2.5
android.numeric_version = 1000205002
# always "1" -------------^|||||||||
# 0.2.5 ----> 00 02 05 ----^^^^^^|||
# #commits since last tag -------^^|
# 1 = armeabi-v7a, 2 = arm64-v8a --^
# ===================================

[buildozer]
log_level = 2
warn_on_root = 1
