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

open External_js
open Js_utils

let link_css url =
  let link = Dom_html.createLink doc in
  link##href <- _s url;
  link##rel <- _s "stylesheet";
  Dom.appendChild Dom_html.window##document##head link

let script url =
  let script = Dom_html.createScript doc in
  script##src <- _s url;
  script##_type <- _s "text/javascript";
  Dom.appendChild Dom_html.window##document##head script

let title str =
  let title_el = Dom_html.createTitle doc in
  title_el##text <- _s str;
  Dom.appendChild Dom_html.window##document##head title_el


let header t =
  script reveal_head;
  script reveal_js;
  link_css reveal_css;
  link_css reveal_theme;
  link_css reveal_theme_white;
  link_css reveal_zenburn_css;
  title t

let rec mk_sections slides s =
  let open Slides in
  match slides with
  | Single (content, config) ->
    let section = doc##createElement (_s "section") in
    section##setAttribute(_s "data-markdown", _s "");
    s##setAttribute(_s "data-transition",
                    _s (of_transition config.transition));
    s##setAttribute(_s "data-background",
                    _s (of_color config.background_color));
    begin match config.background_img with
    | None -> ()
    | Some img_path ->
      s##setAttribute(_s "data-background", _s (img_path))
    end;
    begin match config.background_video with
    | None -> ()
    | Some video_path ->
      section##setAttribute(_s "data-background-video", _s (video_path));
      section##setAttribute(_s "data-background-video-loop", _s "");
      section##setAttribute(_s "data-autoplay", _s "");
    end;
    begin match config.background_embed with
    | None -> ()
    | Some embed_url ->
      s##setAttribute(_s "data-background-iframe", _s (embed_url))
    end;
    let template = Dom_html.createScript doc in
    template##_type <- _s "text/template";
    begin match config.video with
    | None -> template##text <- _s (Omd.to_markdown content);
    | Some video_path ->
      template##text <- _s
        (Omd.to_markdown content ^ "<video class=\"streched\" src=" ^ video_path ^"></video>")
    end;
    Dom.appendChild section template;
    [section]

  | Multiple slides ->
    List.fold_left (fun acc slide -> acc @ mk_sections slide s) [] slides
  | File (content, _) -> assert false
  (*   let section = doc##createElement (_s "section") in *)
  (*   section##setAttribute(_s "data-mardown", _s ""); *)
  (*   (\* section##setAttribute(_s "data-separator", _s "\\n---\\n"); *\) *)

  (*   let template = Dom_html.createScript doc in *)
  (*   template##_type <- _s "text/template"; *)
  (*   Firebug.console##log (_s (Omd.to_markdown content)); *)
  (*   template##text <- _s (Omd.to_markdown  content); *)
  (*   Dom.appendChild section template; *)

  (*   [section] *)

let create_slide slides =
  let section = doc##createElement (_s "section") in
  let subsections = mk_sections slides section in
  List.iter (fun s ->
    Dom.appendChild section s) subsections;
  section

let body slides =
  let div_reveal = Dom_html.createDiv doc in
  div_reveal##className <- _s "reveal";
  let div_slides = Dom_html.createDiv doc in
  div_slides##className <- _s "slides";

  List.iter (fun raw_slide ->
    let section = create_slide raw_slide in
    Dom.appendChild div_slides section)
    slides;
  Dom.appendChild div_reveal div_slides;
  Dom.appendChild Dom_html.window##document##body div_reveal


let make title slides =
  header title;
  body slides;
  Reveal.initialize ()
