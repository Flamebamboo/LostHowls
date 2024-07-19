extends Node2D
@export var speed = 800
@export var damage: int = 50

func _physics_process(delta):
	position += transform.x * speed * delta
	for body in $BulletHurtbox.get_overlapping_bodies():
		queue_free()
		if body is Player:
			if body.has_method("take_damage"):
				body.take_damage(damage)
				queue_free()
				break
	
	

func _on_timer_timeout():
	queue_free()
