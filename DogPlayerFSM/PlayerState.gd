extends BaseState
class_name PlayerState

@export var player: Player
@onready var physics = %"Physics Components"
#flags
var can_jump = true
var can_run = true
var can_fall = true

