extends CharacterBody2D
@export var speed = 650
var max_distance : float = 5000.0
var travelled_distance = 0.0

func _physics_process(delta):
	var velocity = transform.x * speed * delta
	var collision = move_and_collide(velocity)
	if collision:
		queue_free()
		travelled_distance += velocity.length()
		if travelled_distance >= max_distance:
			queue_free()
	

