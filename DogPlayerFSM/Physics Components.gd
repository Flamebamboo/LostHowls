class_name PhysicsComponent
extends Node
@export var player : Player

#var gravity = 30
#var terminal_velocity = 1000

@export var jump_height: float
@export var jump_time_to_peak: float 
@export var jump_time_to_fall: float 

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_fall)) * -1.0


@export var air_resistance = 10



var velocity = Vector2(0,0)

var y_dir := 1


@export var acceleration: float
@export var friction: float 
@export var max_speed: float 


func _physics_process(_delta):
	player.velocity = velocity
	player.move_and_slide()
	

func apply_gravity(delta: float = get_physics_process_delta_time()):
	if velocity.y < 0:
		velocity.y += jump_gravity * delta
	else:
		velocity.y += fall_gravity * delta
		velocity.y = min(velocity.y, fall_gravity * jump_time_to_fall)
	
		
	
	

func gravity_direction():
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func ground_accel(delta: float = get_physics_process_delta_time()):
	var direction = Input.get_axis("moveleft", "moveright")
	velocity.x = lerp(velocity.x, direction * max_speed,(acceleration/ 100) * delta)
	#lerp(a, b, t) = a + (b - a) * t
	#acceleration/100 times delta is interpolation factor

	

func ground_decel(delta: float = get_physics_process_delta_time()):
	velocity.x = move_toward(velocity.x, 0, friction * delta)
	
func horizontal_air_resistance(delta: float = get_physics_process_delta_time()):
	if !owner.is_on_floor() && !owner.is_on_wall():
		velocity.x  = move_toward(velocity.x, 0, air_resistance * delta)
		
func vertical_air_resistance(delta: float = get_physics_process_delta_time()):
	if !owner.is_on_floor() && !owner.is_on_wall():
		velocity.y = move_toward(velocity.y, 0, air_resistance * delta)
	
	
func jump():
	velocity.y = jump_velocity
