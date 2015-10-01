(*****************************************************************************)
(*                                                                           *)
(*  Copyright 2015 OCamlPro                                                  *)
(*                                                                           *)
(*  All rights reserved.  This file is distributed under the terms of        *)
(*  the Lesser GNU Public License version 3.0.                               *)
(*                                                                           *)
(*  This software is distributed in the hope that it will be useful,         *)
(*  but WITHOUT ANY WARRANTY; without even the implied warranty of           *)
(*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *)
(*  Lesser GNU General Public License for more details.                      *)
(*                                                                           *)
(*****************************************************************************)

open Js_utils

class type math = object
  method config : Js.js_string Js.t Js.prop
end

class type dependencies = object
  method src : Js.js_string Js.t Js.prop
  method condition : unit -> bool Js.t Js.prop
  method callback : unit -> bool Js.t Js.prop
  method async : bool Js.t Js.prop
end

class type reveal = object
  method controls : bool Js.t Js.prop
  method progress : bool Js.t Js.prop
  method history : bool Js.t Js.prop
  method center : bool Js.t Js.prop
  method math : math Js.t Js.prop
  method dependencies : dependencies Js.t Js.js_array Js.t Js.prop
end

let dep ?(async=None) ?(condition=None) ?(callback=None) src =
  let obj = Js.Unsafe.obj [||] in
  obj##src <- _s src;
  begin match async with
  | None -> ()
  | Some async -> obj##async <- async
  end;
  begin match condition with
  | None -> ()
  | Some condition -> obj##condition <- condition
  end;
  begin match callback with
  | None -> ()
  | Some callback -> obj##callback <- callback
  end;
  obj

let initialize () =
  let open External_js in

  (* Interpret latex math with MathJax *)
  let math : math Js.t = Js.Unsafe.obj [||] in
  math##config <- _s "TeX-AMS_HTML-full";

  let deps = Js.array [|

    (** Cross-browser shim that fully implements classList -
        https://github.com/eligrey/classList.js/ *)
    dep
      ~async:None
      ~condition:(Some (fun () ->
        doc##body##classList##length <> 0))
      classList_js;

    (** Interpret Markdown in <section> elements. *)
    dep
      ~condition:(Some (fun () -> doc##querySelector (_s "[data-markdown]")))
      marked_js;
    dep
      ~async:None
      ~condition:(Some (fun () -> doc##querySelector (_s "[data-markdown]")))
      markdown_js;

    (** Syntax highlight for <code> elements. *)
    dep
      ~callback:(Some (fun () -> (Js.Unsafe.global##hljs)##initHighlighting()))
      highlight_js;

    (** Speaker notes. *)
    dep note_js;

    (** MathJax : math equations (cf latex syntax) *)
    dep math_js;

    (** Zoom in and out with Alt+click *)
    dep ~async:(Some Js._true) zoom_js |] in

  let reveal : reveal Js.t = Js.Unsafe.obj [||] in
  reveal##controls <- Js._true;
  reveal##progress <- Js._true;
  reveal##history <- Js._true;
  reveal##center <- Js._true;
  reveal##math <- math;
  reveal##dependencies <- deps;

  (* We have to wait until all initialization scripts are correctly loaded. *)
  Dom_html.window##onload <-
    Dom_html.handler (fun _ ->
      Js.Unsafe.global##_Reveal##initialize(reveal));
