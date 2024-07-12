extends RigidBody2D
#rock3
var initial_position: Vector2
var target_position: Vector2
var player_on_rock: bool = false

# Rock movement parameters
@export var float_height: float = 50.0
@export var float_speed: float = 100.0
@export var sink_height: float = 20.0
@export var sink_speed: float = 200.0
@export var return_speed: float = 100.0

func _ready():
	initial_position = global_position
	target_position = initial_position + Vector2(0, -float_height)
	global_position = target_position

func _process(delta):
	#only if player is on rock it will stay down if not it go back up
	if not player_on_rock:
		move_towards_position(target_position, float_speed * delta)
	else:
		
		#sink
		move_towards_position(initial_position + Vector2(0, sink_height), sink_speed * delta)

# Function to move the rock towards a target position
func move_towards_position(target: Vector2, speed: float):
	var current_position = global_position
	var direction = (target - current_position).normalized()
	global_position += direction * speed
	if global_position.distance_to(target) < 1.0:
		global_position = target

# Function to detect player entering the rock's area

func _on_area_2d_body_entered(body):
	if body.name == "dog":
		player_on_rock = true

func _on_area_2d_body_exited(body):
	if body.name == "dog":
		player_on_rock = false
