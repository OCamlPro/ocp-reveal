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

type transition = None | Fade | Slide | Convex | Concave | Zoom

type color = Black | White | Blue | Red | Color of string

type path = string

type slide = {
  title : Omd.element;
  content : string;
  transition : transition;
  video: path option;
  text_color : color;                   (* xxx TODO *)
  background_color : color;
  background_img : path option;
  background_video : path option;
  background_embed : path option;
}

type slide_t =
| Single of (Omd.t * slide)  (* One single slide *)
| Multiple of slides_t       (* Vertical navigation for subsections *)
| File of (Omd.t * slide)    (* xxx TODO Load content from file *)

and slides_t = slide_t list

val title1 : string -> Omd.element
val title2 : string -> Omd.element
val title3 : string -> Omd.element
val title4 : string -> Omd.element
val title5 : string -> Omd.element
val title6 : string -> Omd.element

val text : string -> Omd.element
val bold : string -> Omd.element
val emph : string -> Omd.element

val paragraph : Omd.t -> Omd.element
val itemize : string list -> Omd.element
val enumerate : string list -> Omd.element

val of_transition : transition -> string

val of_color : color -> string

(** Predefine slide named by effect transition. *)
val default : slide
val slide : slide
val convex : slide
val concave : slide
val fade : slide
val zoom : slide

(** Create a new frame. *)
val frame : slide -> slide_t
