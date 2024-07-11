
extends CharacterBody2D

var travelled_distance = 0.0


@export var speed: int =  500
@export var ranges: int = 300
@export var damage: int = 10

func _ready():
	add_to_group("bullet")
	Global.BulletCharacter = self

func _physics_process(delta):
	#to be used for auto aiming
	#position += velocity * delta
	#travelled_distance += velocity.length() * delta
	#if travelled_distance > ranges: 
	var direction = Vector2.RIGHT.rotated(rotation)
	
	velocity = direction*speed
	move_and_collide(velocity*delta)
	
	
	
	
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
