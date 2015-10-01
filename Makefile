OCPBUILD=ocp-build
JSFILE=ocp-reveal.js

all: build

all-ocp:
	$(OCPBUILD) build

build:
	$(MAKE) -C src

examples: build
	$(MAKE) -C examples

clean-ocp:
	$(OCPBUILD) clean

clean:
	$(MAKE) -C src clean
	$(MAKE) -C examples clean
	@rm -f js/ocp-reveal.js
