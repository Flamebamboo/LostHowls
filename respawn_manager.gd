extends Node
class_name RespawnManager ##firecamps are automatically set as respawn_points group
@export var health_components: PlayerHealth
@export var player: CharacterBody2D
signal PlayerAlive

func respawn_player():
	var last_checkpoints = CheckpointManager.get_checkpoint()
	
	if last_checkpoints:
		player.global_position = last_checkpoints
	

	emit_signal("PlayerAlive")
	Global.dogAlive = true
func _on_health_components_died():
	respawn_player()
	
