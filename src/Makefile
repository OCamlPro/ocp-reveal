SOURCES=\
  external_js.ml \
  js_utils.mli js_utils.ml \
  slides.mli slides.ml \
  reveal.mli reveal.ml \
  html.ml

PACKAGES= \
  -package js_of_ocaml \
  -package js_of_ocaml.syntax \
  -package omd

SYNTAXES=-syntax camlp4o

TARGET=ocp-reveal

all: $(TARGET).cma

$(TARGET).cma: $(SOURCES)
	ocamlfind ocamlc -bin-annot $(PACKAGES) $(SYNTAXES) -linkpkg $(SOURCES) -a -o ocp-reveal.cma

clean:
	@rm -f *.o *.byte *.cmo *.cmi *.cma *.cmt *.cmti
