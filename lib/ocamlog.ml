(**************************************************************************************************
*********************[ INCLUDES ]******************************************************************
**************************************************************************************************)

open Color
open Level
open Printf
open Unix

module Color = Color
module Level = Level

(**************************************************************************************************
*********************[ CONSTANTS ]*****************************************************************
**************************************************************************************************)

let firstLine = "┌───────────────────────────────────────────────────────────────────────"
let firstChar = "│"
let midLine   = "├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"
let lastLine  = "└───────────────────────────────────────────────────────────────────────"

(**************************************************************************************************
*********************[ UTILS ]*********************************************************************
**************************************************************************************************)

let decoration = ref false

let make_decoration str lvl location =
  sprintf " %s %s\n %s %s Location : %s\n %s %s\n %s %s ➤ %s\n %s %s"
    lvl firstLine
    lvl firstChar location
    lvl midLine
    lvl firstChar str
    lvl lastLine

let get_time =
  let ts = gettimeofday() in
  let tm = localtime ts in
  let us, _s = modf ts in
  sprintf "%02d:%02d:%02d.%03d"
    tm.Unix.tm_hour
    tm.Unix.tm_min
    tm.Unix.tm_sec
    (int_of_float (1_000. *. us))

let file_caller (str : string) =
  let split1 =
    String.split_on_char '"' str
    |> List.rev in
  let file = List.nth split1 1 in
  let line_char = List.hd split1 in
  let split3 =
    List.nth (String.split_on_char ',' line_char) 1
    |> String.split_on_char ' ' in
  let line = List.nth split3 2 in
  file, line

(**************************************************************************************************
*********************[ PRINT ]*********************************************************************
**************************************************************************************************)

let print str color =
  let color' = color_to_string color in
  let r = color_to_string Reset in
  printf "%s%s%s" color' str r

let println str color =
  let str' = str ^ "\n" in
  print str' color

let print_time str color =
  let str' = sprintf "%s %s" get_time str in
  println str' color

let print_location str lvl location color =
  if !decoration then
    let lvlStr = level_to_upper_string lvl in
    let str' = make_decoration str lvlStr location in
    println str' color
  else
    let lvlStr = level_to_string lvl in
    let str' = sprintf " (%s) %s" lvlStr str in
    print location Grey;
    println str' color

(**************************************************************************************************
*********************[ PUBLIC ]********************************************************************
**************************************************************************************************)

let set_decoration value   = decoration := value
let enable_decorations  () = decoration := true
let disable_decorations () = decoration := false

let print ?loc lvl str =
  let file, line =
    Printexc.get_callstack 2
    |> Printexc.raw_backtrace_to_string
    |> file_caller in

  let location =
    match loc with
    | Some(s1, s2) -> sprintf "[%s:%s]" s1 s2
    | None -> sprintf "[%s:%s]" file line
  in

  let color = level_to_color lvl in
  print_location str lvl location color

(**************************************************************************************************
*********************[ EOF ]***********************************************************************
**************************************************************************************************)
