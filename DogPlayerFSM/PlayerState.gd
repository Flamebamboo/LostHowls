extends BaseState
class_name PlayerState



@onready var player := Player
@onready var physics := %"Physics Components"
#FLAGS SOON: eg can_dash, and in states machine.active_state.can_dash.

#Player defaults states 
var can_idle: bool  = true
var can_jump: bool  = true
var can_air: bool  = true
var can_run: bool  = true
var can_push: bool = true

#player can obtain state

var can_glide: bool = false



