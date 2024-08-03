extends Area2D
class_name Hurtbox
@export var health_components: BaseHealth
##TO DO MAKE IMPACT SCENE AND INSTANCE IT HERE ALSO CREATE PUT SHAKE

@export var bullet_impact: PackedScene

	
	
	
func apply_damage(damage):
	print(damage, "damage amount")
	if health_components.health > 0: #if both of this conditions are met damage will be applied to health components
		health_components.take_damage(damage) 
		
			
			
			#if bullet_impact:
				#var impact_show = bullet_impact.instantiate()
				#impact_show.global_position = body.global_position
				#get_parent().add_child(impact_show)
			
	##this is honestly not scalable
	#The hurting shouldn't know what it is
	#The hurting should just see an entity to hurt
	#Not check what the entity is
	#It shouldn't care what it is
	#Inheritance is good if everything will share this functionality
	
	
	#change in health signal 
	#this func will take bullet as a argument to check if classname health, health is > 0
	#since hurtbox component is a shared functionality between enemies and player
	
	##TO DO:
	#instance bullet impact scene here

	




