open Color

type level =
  | Trace
  | Info
  | Warning
  | Error

val levelToString : level -> string
val levelToColor : level -> color