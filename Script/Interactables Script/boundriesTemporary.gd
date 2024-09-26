extends Area2D

@export var player: CharacterBody2D

func _on_body_entered(body):
	player.instantdeath()
	ScreenGui.play_animation("redflash")
