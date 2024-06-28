extends Area2D
class_name Hurtbox
@export var health_components: Health
@export var damage = 1
#bullet impact vfx scene export here 

@export var bullet_impact: PackedScene

func _ready():
	pass

func _physics_process(delta):
	for body in %"Hurtbox Components".get_overlapping_bodies():
		if body.is_in_group("dog"):
			if body.has_method("take_damage"):
				body.take_damage(damage)
				break
				
	
	#this func will take bullet as a argument to check if classname health, health is > 0
	#all other logic 
func on_bullet_collisions(bullet):
	if bullet.is_in_group("bullet"):
		var impact = bullet_impact.instantiate()
		if impact:
			get_tree().root.call_deferred("add_child",impact)
			impact.global_position = bullet.global_position
			impact.queue_free()
	
		if health_components.health > 0:
			var bulletDamage = bullet.damage #body.damage is from the bullet damage amount
			health_components.takedamage(bulletDamage) 
			

			
			
		
	#instance bullet impact scene here
	#change in health signal 
	
