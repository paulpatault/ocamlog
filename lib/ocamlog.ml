open Color
open Printf
open Unix

let get_date =
  let ts = gettimeofday() in
  let tm = localtime ts in
  sprintf "%04d-%02d-%02d"
    (1900 + tm.Unix.tm_year)
    (1    + tm.Unix.tm_mon)
    tm.Unix.tm_mday

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

let printFtLocation str color location =
  let str' = sprintf " %s" str in
  print location Grey;
  println str' color

let printTrace str =
  let file, line =
    Printexc.get_callstack 2
    |> Printexc.raw_backtrace_to_string
    |> fileCaller in
  let f = sprintf "[%s:%s]" file line in
  let str' = sprintf "(Trace) %s" str in
  printFtLocation str' Default f

let printInfo str  =
  let file, line =
    Printexc.get_callstack 2
    |> Printexc.raw_backtrace_to_string
    |> fileCaller in
  let f = sprintf "[%s:%s]" file line in
  let str' = sprintf "(Info) %s" str in
  printFtLocation str' Green f

let printWarn str =
  let file, line =
    Printexc.get_callstack 2
    |> Printexc.raw_backtrace_to_string
    |> fileCaller in
  let f = sprintf "[%s:%s]" file line in
  let str' = sprintf "(Warn) %s" str in
  printFtLocation str' Yellow f

let printError str =
  let file, line =
    Printexc.get_callstack 2
    |> Printexc.raw_backtrace_to_string
    |> fileCaller in
  let f = sprintf "[%s:%s]" file line in
  let str' = sprintf "(Red) %s" str in
  printFtLocation str' Red f
