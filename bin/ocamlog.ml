open Color
open Printf
open Unix

let date =
  let ts = gettimeofday() in
  let tm = localtime ts in
  sprintf "%04d-%02d-%02d"
    (1900 + tm.Unix.tm_year)
    (1    + tm.Unix.tm_mon)
    tm.Unix.tm_mday

let time =
  let ts = gettimeofday() in
  let tm = localtime ts in
  let us, _s = modf ts in
  sprintf "%02d:%02d:%02d.%03d"
    tm.Unix.tm_hour
    tm.Unix.tm_min
    tm.Unix.tm_sec
    (int_of_float (1_000. *. us))

let location =
  let file = __FILE__ in
  let line = sprintf "%d" __LINE__ in
  let func = __FUNCTION__ in
  sprintf "[%s:%s (%s)]" file line func

let print str color =
  let color' = colorToString color in
  let r = colorToString Reset in
  printf "%s%s%s" color' str r

let println str color =
  let str' = str ^ "\n" in
  print str' color

let printtln strin color =
  let str' = sprintf "%s %s" time strin
    (* (level_to_string lvl)
    !prefix *)
  in
  println str' color

let printlln str color =
  let str' = sprintf "%s %s %s" location time str in
  println str' color


let printdtln str color =
  let str' = sprintf "%s %s %s" date time str
    (* (level_to_string lvl)
    !prefix *)
  in
  println str' color


let printTrace str = printtln ("(Trace) " ^ str) Default
let printInfo str  = printtln ("(Info) "  ^ str) Green
let printWarn str  = printtln ("(Warn) "  ^ str) Yellow
let printError str = printtln ("(Error) " ^ str) Red
