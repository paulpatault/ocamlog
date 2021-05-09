open Color

type level =
  | Trace
  | Info
  | Warning
  | Error

val levelToString : level -> string
val levelToUpperString : level -> string
val levelToColor : level -> color
