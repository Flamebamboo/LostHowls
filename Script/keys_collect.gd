extends Area2D


signal key_collected


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("key_collected")
		queue_free()
