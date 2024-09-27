extends Node2D

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)


func _on_next_level_body_entered(body: Node2D) -> void:
	if body is Player:
		LoadManager.load_scene("res://Scenes/EndScreen.tscn", "fade_in")
		Global.game_finished = true
