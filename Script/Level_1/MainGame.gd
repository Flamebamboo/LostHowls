extends Node2D
func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)



	
	
		
		
		#if !next_level is PackedScene: return
		#get_tree().paused = true
		#await LevelTransition.start_transition("fade_to_black")
		#get_tree().paused = false
		#call_deferred("change_scene")
		#await LevelTransition.start_transition("fade_from_black")
		#
#
#func change_scene():
	#get_tree().change_scene_to_packed(next_level)


func _on_next_level_body_entered(body):
	if body is Player:
		LoadManager.load_scene("res://Scenes/LevelTwo.tscn", "fade_from_black")
		
