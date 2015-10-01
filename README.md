# ocp-reveal
A binding to [reveal.js](https://github.com/hakimel/reveal.js) library

`Reveal.js` is a framework for easily creating beautiful presentations using
HTML.

`reveal.js` comes with a broad range of features including nested slides,
Markdown contents, PDF export, speaker notes and a JavaScript API. It's best
viewed in a modern browser but fallbacks are available to make sure your
presentation can still be viewed elsewhere.

# Dependencies

#### Manually

Download and install these packages:

* `ocp-build` : http://www.typerex.org/ocp-build.html
* `omd` : http://www.typerex.org/ocp-build.html
* `js_of_ocaml` : http://ocsigen.org/js_of_ocaml/


#### Using OPAM

    $ opam install ocp-build js_of_ocaml omd

# Build with Makefile

    $ make examples

# Build with ocp-build

    $ make all-ocp

# Example

To try and see your slides, you can check an example in the `examples`
directory:

    $ make && firefox examples/index.html

 or you can see a demo at :

    http://cagdas.bozman.fr/demo-ocp-reveal/#/

# Start your own slides

Compile your project, generate the JavaScript file and add it to your
html file:

```html
<html>
  <head></head>
  <body>
    <script src="PATH/TO/GENERATED/JSFILE"></script>
  </body>
</html>
```
