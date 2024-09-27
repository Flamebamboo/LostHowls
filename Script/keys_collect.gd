extends Area2D


signal key_collected

func _ready() -> void:
	$AnimationPlayer.play("paw")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("key_collected")
		$AnimationPlayer.play("collected")
		SoundManager.button_sound.play()
		await $AnimationPlayer.animation_finished
		queue_free()
