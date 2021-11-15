open Color

type level =
  | Trace
  | Info
  | Warning
  | Error

let level_to_string l =
  match l with
  | Trace   -> "Trace"
  | Info    -> "Info"
  | Warning -> "Warn"
  | Error   -> "Error"

let level_to_upper_string l =
  match l with
  | Trace   -> "TRACE"
  | Info    -> "INFO"
  | Warning -> "WARN"
  | Error   -> "ERROR"

let level_to_color l =
  match l with
  | Trace   -> Default
  | Info    -> Green
  | Warning -> Yellow
  | Error   -> Red

