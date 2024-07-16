class_name PhysicsComponent
extends Node
@export var player : Player

var gravity = 30
var terminal_velocity = 1000

var jump_velocity = 1000

var air_resistance = 0.15

var velocity = Vector2(0,0)

var y_dir := 1

var max_fall_grav: float = 200.0

@export var acceleration: float = 450.0
@export var friction: float = 5000.0
@export var max_speed: float = 400.0

func _physics_process(_delta):
	player.velocity = velocity
	player.move_and_slide()
	


func ground_accel(delta: float = get_physics_process_delta_time()):
	var direction = Input.get_axis("moveleft", "moveright")
	if acceleration > 0:
		velocity.x = lerp(velocity.x, direction * max_speed,(acceleration/ 100) * delta)
		print("Velocity X: ", velocity.x)

func ground_decel(delta: float = get_physics_process_delta_time()):
	velocity.x = move_toward(velocity.x, 0, friction * delta)
		
	
func jump():
	pass	
