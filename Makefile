SHELL := /bin/bash

.PHONY: all spec spec_verbose spec_less docs clean

all:
	coffee -o public/coffee -c src/

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
