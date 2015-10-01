OCPBUILD=ocp-build
JSFILE=ocp-reveal.js

all:
	$(OCPBUILD) build

clean:
	$(OCPBUILD) clean
	@rm -f js/ocp-reveal.js
