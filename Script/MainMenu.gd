extends Control



func _on_button_pressed() -> void:
	LoadManager.load_scene("res://Scenes/StartUpScene.tscn", "black_fade")
func _on_button_2_pressed() -> void:
	ScreenGui.open_pause_menu()


func _on_button_3_pressed() -> void:
	get_tree().quit()
