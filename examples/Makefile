SOURCES=examples.ml
TARGET=ocp-reveal
PACKAGES= \
  -package js_of_ocaml \
  -package js_of_ocaml.syntax \
  -package omd

SYNTAXES=-syntax camlp4o

all: $(TARGET).js

$(TARGET).byte:
	ocamlfind ocamlc $(PACKAGES) $(SYNTAXES) -linkpkg -I ../src ../src/ocp-reveal.cma $(SOURCES) -o $(TARGET).byte

$(TARGET).js: $(TARGET).byte
	js_of_ocaml $(TARGET).byte
	cp $(TARGET).js ../js

clean:
	@rm -f *.o *.js *.byte *.cmo *.cmi *.cma
