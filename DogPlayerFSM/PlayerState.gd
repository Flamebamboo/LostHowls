extends BaseState
class_name PlayerState



@export var player: Player
@onready var physics = %"Physics Components"
#FLAGS SOON: eg can_dash, and in states machine.active_state.can_dash.

#Player states 
var can_idle = true
var can_jump = true
var can_air = true
var can_run = true




