type color =
  | Black
  | Red
  | Green
  | Yellow
  | Blue
  | Magenta
  | Cyan
  | White
  | Grey
  | Default
  | Reset

let color_to_string color =
  match color with
  | Black   -> "\027[30m"
  | Red     -> "\027[31m"
  | Green   -> "\027[32m"
  | Yellow  -> "\027[33m"
  | Blue    -> "\027[34m"
  | Magenta -> "\027[35m"
  | Cyan    -> "\027[36m"
  | White   -> "\027[37m"
  | Grey    -> "\027[90m"
  | Default -> "\027[39m"
  | Reset   -> "\027[0m"
