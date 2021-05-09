open Lib

let () = Ocamlog.enableDecorations ()

let () = Ocamlog.print Trace "Message 1"
let () = Ocamlog.print Info "Message 2"
let () = Ocamlog.print Warning "Message 3"
let () = Ocamlog.print Error "Message 4"

let () = Ocamlog.disableDecorations ()
