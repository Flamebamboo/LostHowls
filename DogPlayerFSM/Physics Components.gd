class_name PhysicsComponent
extends Node
@export var player : Player

var gravity = 30
var terminal_velocity = 1000
var jump_velocity = 600
var air_resistance = 0.15
var run_speed = 300

var velocity = Vector2(0,0)

var y_dir:float = 1.0

var max_fall_grav: float = 200.0

@export var acceleration: float = 10.0
@export var friction: float = 5.0
@export var max_speed: float = 150.0

func _physics_process(_delta):
	player.velocity = velocity
	player.move_and_slide()
	
func apply_gravity():
	velocity.y += gravity * y_dir


func ground_accel(delta: float = get_physics_process_delta_time()):
	var direction = Input.get_axis("moveleft", "moveright")
	if acceleration > 0:
		velocity.x = lerp(velocity.x, direction.x * max_speed,(acceleration/ 100) * delta)
	
	
