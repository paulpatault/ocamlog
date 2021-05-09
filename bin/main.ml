open Lib
open Printexc
open Printf

let () = Ocamlog.printTrace "Error"

let func () = Ocamlog.printInfo "Error"

let () = func ()

let () = Ocamlog.printWarn "Error"
let () = Ocamlog.printError "Error"
