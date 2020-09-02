SHELL       := /bin/bash
BUILDOZER   ?= buildozer
PIP_INSTALL ?= pip install

.PHONY: all spec spec_verbose spec_less docs clean

all:
	coffee -o public/coffee -c src/
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
	buildozer android clean
	rm -fr bin/

.PHONY: android-debug-armeabi-v7a android-debug-arm64-v8a
.PHONY: android-release-armeabi-v7a android-release-arm64-v8a

android-debug-armeabi-v7a:
	APP_ANDROID_ARCH=armeabi-v7a \
	APP_ANDROID_NUMERIC_VERSION=$$(( $(NUMERIC) - 1 )) \
	buildozer android debug

android-debug-arm64-v8a:
	APP_ANDROID_NUMERIC_VERSION=$(NUMERIC) \
	buildozer android debug

android-release-armeabi-v7a:
	APP_ANDROID_ARCH=armeabi-v7a \
	APP_ANDROID_NUMERIC_VERSION=$$(( $(NUMERIC) - 1 )) \
	buildozer android release

android-release-arm64-v8a:
	APP_ANDROID_NUMERIC_VERSION=$(NUMERIC) \
	buildozer android release

.PHONY: _android_setup_root _android_setup_user

_android_setup_root:
	apt-get install -y build-essential git
	apt-get install -y openjdk-11-jdk-headless
	apt-get install -y zlib1g-dev zip unzip pkg-config libffi-dev
	apt-get install -y libltdl-dev
	apt-get install -y lld

_android_setup_user:
	$(PIP_INSTALL) --upgrade $(BUILDOZER)
	$(PIP_INSTALL) --upgrade Cython==0.29.19 virtualenv
