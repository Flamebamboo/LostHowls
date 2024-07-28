extends CharacterBody2D
@export var speed = 600

@export var damage: int = 50
var max_distance : float = 5000.0
var travelled_distance = 0.0
func _physics_process(delta):
	position += transform.x * speed * delta
	for body in $BulletHurtbox.get_overlapping_bodies():
		if body is Player:
			if body.has_method("bullet_damage"):
				body.bullet_damage(damage)
		
				break
	var collision = move_and_collide(velocity)
	if collision:
		queue_free()
		travelled_distance += velocity.length()
		if travelled_distance >= max_distance:
			queue_free()
	

