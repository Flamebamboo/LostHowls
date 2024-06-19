extends Area2D
class_name Hurtbox
@export var health_components: Health

#bullet impact vfx scene export here 

@export var bullet_impact: PackedScene

func _ready():
	pass


		
	
	#this func will take bullet as a argument to check if classname health, health is > 0
	#all other logic 
func on_bullet_collisions(body):
	if body.is_in_group("bullet"):
		var impact = bullet_impact.instantiate()
		if impact:
			get_tree().root.call_deferred("add_child",impact)
			impact.global_position = body.global_position
	
		if health_components.health > 0:
			var bulletDamage = body.damage #body.damage is from the bullet damage amount
			health_components.takedamage(bulletDamage) 
			print(health_components.health)
			
		
	#instance bullet impact scene here
	#change in health signal 
	
