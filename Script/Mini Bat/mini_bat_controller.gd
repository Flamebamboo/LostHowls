extends Node

@export var machine : StateMachine




func _on_entity_detector_body_entered(body):
	if body is Player:
		machine.transition_to(machine.states["LaserState"])
		await get_tree().create_timer(1.0).timeout
		machine.transition_to(machine.states["WanderingState"])
