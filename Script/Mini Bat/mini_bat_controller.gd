extends Node

@export var machine: StateMachine
var can_laser: bool = false

var player_in_bound: bool = false

var tick: float = 100

	
func _physics_process(delta: float) -> void:
	tick -= 1
	print(can_laser)
	if player_in_bound:
		if machine.active_state == machine.states["WanderingState"]:
			machine.transition_to(machine.states["ChaseState"])
		
		if tick <= 0 && can_laser:
			print("shoot")
			machine.transition_to(machine.states["LaserState"])
			can_laser = false
			tick = 100
			
	
		
			


func _on_entity_detector_body_entered(body):
	if body is Player:
		player_in_bound = true
		
			
			
func _on_entity_detector_body_exited(body: Node2D):
	if body is Player:
		player_in_bound = false
		machine.transition_to(machine.states["WanderingState"])

#check if player is in area range to shoot laser
func _on_laser_executer_body_entered(body: Node2D) -> void:
	if body is Player:
		can_laser = true
		

		


func _on_laser_executer_body_exited(body: Node2D) -> void:
	if body is Player:
		can_laser = false
		
