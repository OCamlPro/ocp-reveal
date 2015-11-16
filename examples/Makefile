SOURCE1=examples.ml
SOURCE2=examples_2.ml
TARGET=ocp-reveal
TARGET2=ocp-reveal-2

PACKAGES= \
  -package js_of_ocaml \
  -package js_of_ocaml.syntax \
  -package omd


all: $(TARGET).js $(TARGET2).js

$(TARGET).byte: $(SOURCE1) ../src/ocp-reveal.cma
	ocamlfind ocamlc $(PACKAGES) -linkpkg -I ../src ../src/ocp-reveal.cma $(SOURCE1) -o $(TARGET).byte

$(TARGET).js: $(TARGET).byte
	js_of_ocaml $(TARGET).byte
	mkdir -p ../js
	cp $(TARGET).js ../js

$(TARGET2).byte:$(SOURCE2) ../src/ocp-reveal.cma
	ocamlfind ocamlc $(PACKAGES) -linkpkg -I ../src ../src/ocp-reveal.cma $(SOURCE2) -o $(TARGET2).byte

$(TARGET2).js: $(TARGET2).byte
	js_of_ocaml $(TARGET2).byte
	mkdir -p ../js
	cp $(TARGET2).js ../js

clean:
	@rm -f *.o *.js *.byte *.cmo *.cmi *.cma *.cmt *.cmti
