extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine

@onready var random_timer : Timer = $"../RandomTimer"

# Variable to store the state change interval
var state_change_interval_range = Vector2(1, 3)  # Min and max interval in seconds

func _ready():
	pass

func start_random_timer():
	var interval = randi_range(state_change_interval_range.x, state_change_interval_range.y)
	random_timer.wait_time = interval
	random_timer.start()




func _on_dog_detector_body_entered(body):
	if body.name == "dog":
		print("detectbody")
		start_random_timer()



func _on_random_timer_timeout():
	# Randomly decide whether to transition to "attack" or "idle"
	var should_attack = randi_range(0, 1)
	if should_attack:
		node_finite_state_machine.transition_to("attack")
	else:
		node_finite_state_machine.transition_to("flying")
	
	# Restart the timer with a new random interval
	start_random_timer()
