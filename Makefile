SHELL := /bin/bash

# for reproducible builds
export LC_ALL             := C
export TZ                 := UTC
export SOURCE_DATE_EPOCH  := $(shell git log -1 --pretty=%ct)
export PYTHONHASHSEED     := $(SOURCE_DATE_EPOCH)
export BUILD_DATE         := $(shell LC_ALL=C TZ=UTC date +'%b %e %Y' -d @$(SOURCE_DATE_EPOCH))
export BUILD_TIME         := $(shell LC_ALL=C TZ=UTC date +'%H:%M:%S' -d @$(SOURCE_DATE_EPOCH))

.PHONY: all spec spec_verbose spec_less docs clean

all: public/index.html
	coffee -o public/coffee -c src/

public/index.html: templates/index.html src/*.coffee
	scripts/build.py

spec:
	jasmine-node --coffee spec/

spec_verbose:
	jasmine-node --coffee --verbose spec/

spec_less:
	jasmine-node --coffee --verbose spec/ | less -R

docs:
	docco -o doc src/*.coffee

clean:
	rm -rf doc/ node_modules/ src/*.js

NUMERIC := $(shell grep -oP 'numeric_version *= *\K\d*' buildozer.spec)

.PHONY: android-debug android-clean

android-debug: android-debug-armeabi-v7a android-debug-arm64-v8a

android-clean:
	mkdir -p ../_sokobang_buildozer_
	APP_ANDROID_ARCH=armeabi-v7a buildozer android clean
	buildozer android clean
	rm -fr bin/

.PHONY: android-debug-armeabi-v7a android-debug-arm64-v8a
.PHONY: android-release-armeabi-v7a android-release-arm64-v8a
.PHONY: android-debug android-release

android-debug: android-debug-armeabi-v7a android-debug-arm64-v8a

android-debug-armeabi-v7a:
	APP_ANDROID_ARCH=armeabi-v7a \
	APP_ANDROID_NUMERIC_VERSION=$$(( $(NUMERIC) - 1 )) \
	./scripts/buildozer.sh debug

android-debug-arm64-v8a:
	APP_ANDROID_NUMERIC_VERSION=$(NUMERIC) \
	./scripts/buildozer.sh debug

android-release: android-release-armeabi-v7a android-release-arm64-v8a

android-release-armeabi-v7a:
	APP_ANDROID_ARCH=armeabi-v7a \
	APP_ANDROID_NUMERIC_VERSION=$$(( $(NUMERIC) - 1 )) \
	./scripts/buildozer.sh release

android-release-arm64-v8a:
	APP_ANDROID_NUMERIC_VERSION=$(NUMERIC) \
	./scripts/buildozer.sh release

.PHONY: _android_setup_root _android_setup_user

_android_setup_root:
	./scripts/setup-root.sh

_android_setup_user:
	./scripts/setup-user.sh
