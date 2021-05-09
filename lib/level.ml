open Color

type level =
  | Trace
  | Info
  | Warning
  | Error

let levelToString l =
  match l with
  | Trace   -> "Trace"
  | Info    -> "Info"
  | Warning -> "Warn"
  | Error   -> "Error"

let levelToUpperString l =
  match l with
  | Trace   -> "TRACE"
  | Info    -> "INFO"
  | Warning -> "WARN"
  | Error   -> "ERROR"

let levelToColor l =
  match l with
  | Trace   -> Default
  | Info    -> Green
  | Warning -> Yellow
  | Error   -> Red

