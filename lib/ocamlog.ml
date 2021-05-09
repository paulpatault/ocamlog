(**************************************************************************************************
*********************[ INCLUDES ]******************************************************************
**************************************************************************************************)

open Color
open Level
open Printf
open Unix

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

let makeDecoration str lvl location =
  sprintf " %s %s\n %s %s Location : %s\n %s %s\n %s %s %s\n %s %s"
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

let fileCaller (str : string) =
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
  let color' = colorToString color in
  let r = colorToString Reset in
  printf "%s%s%s" color' str r

let println str color =
  let str' = str ^ "\n" in
  print str' color

let printFtTime str color =
  let str' = sprintf "%s %s" get_time str in
  println str' color

let printFtLocation str lvl location color =
  if !decoration then
    let lvlStr = levelToUpperString lvl in
    let str' = makeDecoration str lvlStr location in
    println str' color
  else
    let lvlStr = levelToString lvl in
    let str' = sprintf " (%s) %s" lvlStr str in
    print location Grey;
    println str' color

(**************************************************************************************************
*********************[ PUBLIC ]********************************************************************
**************************************************************************************************)

let setDecoration value   = decoration := value
let enableDecorations  () = decoration := true
let disableDecorations () = decoration := false

let print lvl str =
  let file, line =
    Printexc.get_callstack 2
    |> Printexc.raw_backtrace_to_string
    |> fileCaller in

  let location = sprintf "[%s:%s]" file line in
  let color = levelToColor lvl in
  printFtLocation str lvl location color

(**************************************************************************************************
*********************[ EOF ]***********************************************************************
**************************************************************************************************)
