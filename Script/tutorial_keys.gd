extends Area2D

@export var _tutorial_sprites: AnimatedSprite2D
@export var _animation_name: String 
@export var _animation_player: AnimationPlayer
func _ready() -> void:
	_tutorial_sprites.visible = false
	_animation_player.play("RESET")

	


func _on_body_entered(body: Node2D) -> void:
	_tutorial_sprites.visible = true
	_animation_player.play(_animation_name)

func _on_body_exited(body: Node2D) -> void:
	_tutorial_sprites.visible = false
	_animation_player.play_backwards(_animation_name)
