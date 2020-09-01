[app]
title = Sokoban(g)
package.name = sokobang
package.domain = dev.obfusk
source.dir = .
source.exclude_dirs = bin,deps,icon,scripts,spec,src
source.exclude_patterns = makefile
requirements = python3,flask
icon.filename = %(source.dir)s/icon.png
orientation = portrait
fullscreen = 0
android.api = 29
android.minapi = 21
android.ndk = 20b
#android.ndk_path =
#android.sdk_path =
android.accept_sdk_license = True
android.arch = arm64-v8a
p4a.branch = develop
#p4a.source_dir =
p4a.bootstrap = webview
p4a.port = 24235

# === DON'T FORGET TO UPDATE THIS ===
version = 0.1.3
android.numeric_version = 1000103002
# always "1" -------------^|||||||||
# 0.1.3 ----> 00 01 03 ----^^^^^^|||
# #commits since last tag -------^^|
# 1 = armeabi-v7a, 2 = arm64-v8a --^
# ===================================

[buildozer]
log_level = 2
warn_on_root = 1
