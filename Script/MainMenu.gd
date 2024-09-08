extends Control



	
	


func _on_button_pressed() -> void:
	LoadManager.load_scene("res://Scenes/MainGame.tscn", "fade_in")
