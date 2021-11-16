module Color : sig
  type color
  val color_to_string : color -> string
end

module Level : sig
  type level = Trace | Info | Warning | Error
  val level_to_string : level -> string
  val level_to_upper_string : level -> string
  val level_to_color : level -> Color.color
end

val enable_decorations : unit -> unit
val disable_decorations : unit -> unit
val set_decoration : bool -> unit

val print : ?loc:string * string -> Level.level -> string -> unit
