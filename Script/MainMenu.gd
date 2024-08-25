extends Control
@onready var button = $Panel/Button



func _on_button_pressed():
	ScreenGui.play_animation("fade_in")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")
