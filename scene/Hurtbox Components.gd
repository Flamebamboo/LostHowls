extends Area2D
class_name Hurtbox
@export var health_components: Health

#bullet impact vfx scene export here 

@export var bullet_impact: PackedScene

func _ready():
	pass


		
	
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
			print(health_components.health)
			print("taking damage")
			
		
	#instance bullet impact scene here
	#change in health signal 
	
