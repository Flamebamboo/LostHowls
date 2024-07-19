extends AnimatableBody2D
#bigrock
var initial_position: Vector2
var target_position: Vector2
var player_on_rock: bool = false

@export var float_height: float = 50.0
@export var float_speed: float = 100.0
@export var sink_height: float = 20.0
@export var sink_speed: float = 200.0


func _ready():
	initial_position = global_position 
	target_position = initial_position + Vector2(0, -float_height)
	global_position = target_position

func _process(delta):
	if !player_on_rock:
		global_position = global_position.move_toward(target_position, float_speed * delta)
	else:
		global_position = global_position.move_toward(initial_position + Vector2(0, sink_height), sink_speed * delta)

# Function to move the rock towards a target position
#func move_towards_position(target: Vector2, speed: float):
	#var current_position = global_position
	#var direction = (target - current_position).normalized()
	#current_position += direction * speed

# Function to detect player entering the rock's area

func _on_area_2d_body_entered(body):
	if body is Player:
		player_on_rock = true
		print("touch")
func _on_area_2d_body_exited(body):
	if body is Player:
		player_on_rock = false
		print("hell")
