[app]
title = Sokoban(g)
package.name = sokobang
package.domain = dev.obfusk
source.dir = .
source.exclude_dirs = badges,bin,deps,fastlane,icon,p4a-recipes,scripts,spec,src,templates
source.exclude_patterns = makefile,static.json
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
p4a.local_recipes = ./p4a-recipes
p4a.bootstrap = webview
p4a.port = 24235

# === DON'T FORGET TO UPDATE THIS ===
version = 0.2.1
android.numeric_version = 1000201002
# always "1" -------------^|||||||||
# 0.2.1 ----> 00 02 01 ----^^^^^^|||
# #commits since last tag -------^^|
# 1 = armeabi-v7a, 2 = arm64-v8a --^
# ===================================

[buildozer]
log_level = 2
warn_on_root = 1
