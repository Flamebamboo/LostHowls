extends CharacterBody2D
class_name MovableRock
@onready var rock: AnimatedSprite2D = $Rock

var is_pushing: bool = false
var is_pulling: bool = false
const push_speed: float = 60.0
const pull_speed: float = 60.0

const push_acceleration: float = 5.0
const pull_acceleration: float = 5.0

var direction: int = 0  # This will indicate movement direction


#conditions
var can_push_from_left: bool = false
var can_pull_from_left: bool  = false

var can_push_from_right: bool = false 
var can_pull_from_right: bool = false



func _physics_process(delta: float) -> void:
	
	
	
	# Apply gravity if the object is not on the floor
	if !is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_pressed("moveleft") and Input.is_action_pressed("moveright"):
		return
	# Pushing logic
	if Input.is_action_pressed("pushbox") and Input.is_action_pressed("moveright") && can_push_from_left == true:
		direction = 1  # Moving to the right
		velocity.x = lerp(velocity.x, direction * push_speed, push_acceleration * delta)
	
		print("Pushing to the right")
	
	elif Input.is_action_pressed("pullbox") and Input.is_action_pressed("moveleft") && can_pull_from_left == true:
		direction = -1  # Moving to the left
		velocity.x = lerp(velocity.x, direction * pull_speed, pull_acceleration * delta)
		print("Pulling to the left")
	
	# Pulling logic - when moving in the opposite direction
	elif Input.is_action_pressed("pushbox") and Input.is_action_pressed("moveleft") && can_push_from_right == true:
		direction = -1  # Moving to the left
		velocity.x = lerp(velocity.x, direction * push_speed, push_acceleration * delta)
		print("Pushing to the left")
	
	elif Input.is_action_pressed("pullbox") and Input.is_action_pressed("moveright") && can_pull_from_right == true:
		direction = 1  # Moving to the right
		velocity.x = lerp(velocity.x, direction * pull_speed, pull_acceleration * delta)
		print("Pulling to the right")
	
	# Stop movement if no valid action is pressed
	else:
		velocity.x = lerp(velocity.x, 0.0, push_acceleration * delta)

	
	move_and_slide()

# When the player enters the left or right side of the object
func _on_l_area_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player on left side, can push/pull")
		can_push_from_left = true
		can_pull_from_left = true
		rock.play("After")

func _on_r_area_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player on right side, can push/pull")
		can_push_from_right = true
		can_pull_from_right = true
		rock.play("After")
# Reset when the player exits the left or right side
func _on_l_area_body_exited(body: Node2D) -> void:
	if body is Player:
		print("Player left the left side")
		can_push_from_left = false
		can_pull_from_left = false
		rock.play("Before")

func _on_r_area_body_exited(body: Node2D) -> void:
	if body is Player:
		print("Player left the right side")
		can_push_from_right = false
		can_pull_from_right = false
		rock.play("Before")
