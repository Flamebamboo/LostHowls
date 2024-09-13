extends BaseHealth
class_name PlayerHealth
@export var player : Player


func _ready():
	health = health_max

func _on_took_damage():
	%ProgressBar.value = health
	player.sprite_flash()
	owner.camera.apply_shake(40.0, 10.0) #why throwing error here hmm
	SoundManager.impact_sound.play()
	ScreenGui.play_animation("redflash")
func _on_respawn_manager_player_alive():
	health = health_max
	%ProgressBar.value = health_max
	await get_tree().create_timer(2).timeout
	Global.dogAlive = true
	Global
