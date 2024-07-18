extends BaseHealth
class_name PlayerHealth
@export var player : Player


func _ready():
	health = health_max

func _on_took_damage():
	%ProgressBar.value = health
	player.sprite_flash()

func _on_respawn_manager_player_alive():
	health = health_max
	%ProgressBar.value = health_max
