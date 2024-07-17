class_name PhysicsComponent
extends Node
@export var player : Player


@export var jump_height: float
@export var jump_time_to_peak: float 
@export var jump_time_to_fall: float 

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_fall)) * -1.0
@export var allowed_jump: int = 2

var jump_count: Array[Vector2] = []


@export var air_resistance = 1000



var velocity = Vector2(0,0)

var input_axis = Input.get_axis("moveleft", "moveright")


@export var acceleration: float
@export var friction: float 
@export var max_speed: float 

@export var air_accel = 200
	
	
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
	var input_axis = Input.get_axis("moveleft", "moveright")
	velocity.x = lerp(velocity.x, input_axis * max_speed,(acceleration/ 100) * delta)
	#lerp(a, b, t) = a + (b - a) * t
	#acceleration/100 times delta is interpolation factor

	

func ground_decel(delta: float = get_physics_process_delta_time()):
	velocity.x = move_toward(velocity.x, 0, friction * delta)


func horizontal_air_strafe(delta: float = get_physics_process_delta_time()):
	var input_axis = Input.get_axis("moveleft", "moveright")
	if !owner.is_on_floor() && !owner.is_on_wall():
		velocity.x = move_toward(velocity.x, air_accel * input_axis, air_resistance * delta)


func vertical_air_resistance(delta: float = get_physics_process_delta_time()):
	if !owner.is_on_floor() && !owner.is_on_wall():
		velocity.y = move_toward(velocity.y, 0, air_resistance * delta)
	

func can_jump():
	var available_jump: bool = jump_count.size() < allowed_jump
	return available_jump	


func jumps():
	if can_jump:
		var tween = create_tween()
		tween.tween_property(%AnimatedSprite2D, "scale:x", 1.0, 0.4).from(0.85).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE)
		velocity.y = jump_velocity
		jump_count.append(Vector2())
		if owner.is_on_floor():
			jump_count.clear()
	
