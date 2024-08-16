extends Area2D
@export var light: PointLight2D
@export var firecamp: AnimatedSprite2D 

func _ready():
	firecamp.play("no_fire")
	light.hide()
	
func _on_body_entered(body):
	if body is Player:
		firecamp.play("fire")
		light.show()
		CheckpointManager.add_checkpoint(global_position)


