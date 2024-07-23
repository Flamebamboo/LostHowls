
extends CharacterBody2D

var travelled_distance = 0.0
@export var speed: int =  350
@export var damage: int = 10
var direction = Vector2(0,0)
var max_distance : float = 5000.0
func _ready():
	add_to_group("bullet")
	var mouse_position = get_global_mouse_position()
	direction = (mouse_position - self.global_position).normalized()
	#max_distance = global_position.distance_to(mouse_position)
func _physics_process(delta):
	var velocity = direction * speed * delta
	move_and_collide(velocity)
	var collision = move_and_collide(velocity)
	if collision:
		queue_free()
		travelled_distance += velocity.length()
		if travelled_distance >= max_distance:
			queue_free()
	
	for body in $BulletHurtbox.get_overlapping_bodies():
				if body.is_in_group("enemies"):
					if body.has_method("take_bullet_damage"):
						body.take_bullet_damage(damage)
						queue_free()
						break


func _on_bullet_hurtbox_area_entered(area):
	if area.is_in_group("breakable objects"):
		queue_free()
		if area.has_method("object_damage"):
			area.object_damage(10)
#
#
