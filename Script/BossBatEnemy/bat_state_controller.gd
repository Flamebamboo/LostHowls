extends Node
@export var machine : StateMachine

@onready var random_timer : Timer = $"../RandomTimer"

var triggered: bool = false

func _physics_process(delta):
	if !Global.dogAlive:
		triggered = false



func _on_random_timer_timeout():
	$"../AudioStreamPlayer".play()
	if Global.dogAlive && machine.active_state.name == "FlyingState":
		# Randomly decide whether to transition to "charge" or "shoot"
		var attack_types = randi_range(0, 1)
		if attack_types:
			machine.transition_to(machine.states["ShootState"])
		else:
			machine.transition_to(machine.states["ChargeState"])
			
	


func _on_entity_detector_body_entered(body):
	if body.is_in_group("player") && !triggered:
		triggered = true
		print("trigger")
		machine.transition_to(machine.states["FlyingState"])
		$"../RandomTimer".start()
		$"../AudioStreamPlayer2".play()
