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


@onready var label = $"../Label"

var jump_count: int = 0


@export var air_resistance = 1000



var velocity = Vector2(0,0)

var input_axis = Input.get_axis("moveleft", "moveright")


@export var acceleration: float
@export var friction: float 
@export var max_speed: float 
@export var speed_multiplier: float
@export var air_accel = 200


## pushing/pull
const push_speed: float = 80.0
const pull_speed: float = 60.0

const push_acceleration: float = 5.5
const pull_acceleration: float = 5.0


	
	
func _physics_process(_delta):	
	if Global.dogFreeze:
		player.velocity = Vector2.ZERO

	else:
		player.velocity = velocity
		player.move_and_slide()
	
	if owner.is_on_floor():
		jump_count = 0
		#label.text = "is on floor"
	#else:
		#label.text = "is not on floor"
	
func apply_gravity(delta: float = get_physics_process_delta_time()):
	if velocity.y < 0:
		velocity.y += jump_gravity * delta
	else:
		velocity.y += fall_gravity * delta
		velocity.y = min(velocity.y, fall_gravity * jump_time_to_fall)
	
	#depending on the player velocity if its going up then we apply jump_gravity 
	#else we use fall gravity also make sure it doesnt exceed the limit by using min
	


func ground_accel(delta: float = get_physics_process_delta_time()):
	var input_axis = Input.get_axis("moveleft", "moveright")
	velocity.x = lerp(velocity.x, input_axis * max_speed,(acceleration/ 100) * delta)
	

	
	#lerp(a, b, t) = a + (b - a) * t
	#lerp will return a value inbetween the first parameter and the second parameter.
	#lerp is like saying the the first value (velocity.x) and add the third paramaeter acceleration until it reaches second
	#eg first parameter is 5 and the second is 10 the last parameter is 0.5
	#lerp will return 7.5
	#acceleration/100 times delta is interpolation factor

	

func ground_decel(delta: float = get_physics_process_delta_time()):
	velocity.x = move_toward(velocity.x, 0, friction * delta)
	#move_toward is like saying current velocity to the second parameter (in this case i want it to stop so "0") 
	#in the speed of friction * delta


###AIR STATE 
func horizontal_air_strafe(delta: float = get_physics_process_delta_time()):
	var input_axis = Input.get_axis("moveleft", "moveright")
	if !owner.is_on_floor() && !owner.is_on_wall():
		velocity.x = move_toward(velocity.x, air_accel * input_axis, air_resistance * delta)
	
	
func vertical_air_resistance(delta: float = get_physics_process_delta_time()):
	if !owner.is_on_floor() && !owner.is_on_wall():
		velocity.y = move_toward(velocity.y, 0, air_resistance * delta)
	

func can_double_jump() -> bool:
	var available_jump: bool = jump_count < allowed_jump
	return available_jump	

##JUMP STATE
func jumps():
	var tween = create_tween()
	tween.tween_property(%AnimatedSprite2D, "scale:x", 1.0, 0.4).from(0.85).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE)
	velocity.y = jump_velocity
	jump_count += 1
	
	
#func double_jump():
	#velocity.y = jump_velocity/2
	#jump_count += 1
	#print("yo")
