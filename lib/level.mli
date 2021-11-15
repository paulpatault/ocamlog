open Color

type level =
  | Trace
  | Info
  | Warning
  | Error

val level_to_string : level -> string
val level_to_upper_string : level -> string
val level_to_color : level -> color
