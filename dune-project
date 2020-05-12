(lang dune 2.5)

(name ocp_reveal)

(license LGPL)

(authors "Çagdas Bozman")

(maintainers "Çagdas Bozman")

(source
 (uri git://github.com/OCamlPro-Bozman/ocp-reveal.git))

(bug_reports https://github.com/OCamlPro-Bozman/ocp-reveal/issues)

(homepage https://github.com/OCamlPro-Bozman/ocp-reveal)

(documentation github.com/OCamlPro-Bozman/ocp-reveal)

(generate_opam_files true)

(package
 (name ocp_reveal)
 (synopsis "OCaml bindings for Reveal.js, an HTML presentation framework")
 (description
   "OCaml bindings for Reveal.js, an HTML presentation framework")
 (depends
  (ocaml
   (>= 4.05))
  (dune
   (>= 2.5))
  (omd
   (>= 1.3))
  (js_of_ocaml
   (>= 3.6))
  (js_of_ocaml-ppx
   (>= 3.6))))
