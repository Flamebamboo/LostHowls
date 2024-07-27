extends Node
@export var machine : StateMachine
@export var raycast: RayCast2D
@onready var random_timer : Timer = $"../RandomTimer"

var target: Player

func _physics_process(delta):
	if raycast.is_colliding():
		if raycast.get_collider() is Player:
			target = raycast.get_collider()
			print(target)



func _on_random_timer_timeout():
	if Global.dogAlive:
		# Randomly decide whether to transition to "attack" or "flying"
		var should_attack = randi_range(0, 1)
		if should_attack:
			machine.transition_to(machine.states["FlyingState"])
		else:
			machine.transition_to(machine.states["AttackState"])
			
		


func _on_entity_detector_body_entered(body):
	if body.is_in_group("player"):
		machine.transition_to(machine.states["ChargeState"])
	
