extends Control
@onready var button = $Panel/Button



func _on_button_pressed():
	LoadManager.load_scene("res://Scenes/MainGame.tscn", "fade_in")
	
