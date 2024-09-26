extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	animation_player.play("IntroStartUp")
	await animation_player.animation_finished
	LoadManager.load_scene("res://Scenes/MainGame.tscn", "black_fade")
