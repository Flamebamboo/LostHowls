extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine


	


func _on_area_2d_body_entered(body):
	if body.is_in_group("dog"):
		node_finite_state_machine.transition_to("attack")


func _on_area_2d_body_exited(body):
	if body.is_in_group("dog"):
		node_finite_state_machine.transition_to("idle")
