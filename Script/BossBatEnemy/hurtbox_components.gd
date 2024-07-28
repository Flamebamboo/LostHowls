extends Area2D
class_name Hurtbox
@export var health_components: BaseHealth

@export var damage = 50


@export var bullet_impact: PackedScene

func _ready():
	pass

	
func _on_body_entered(body):
	if body.is_in_group("bullet"):
		apply_bullet_damage(body)
	

func _on_area_entered(area):
	if area.is_in_group("EnemyHurtbox"):
		apply_player_damage(area)
	



func apply_bullet_damage(body):
	if self.get_parent() is BossBat: #checking the owner of the hurtbox if it has group enemy
			if health_components.health > 0: #if both of this conditions are met damage will be applied to health components
				var bullet_damage = body.damage #body.damage is from the bullet damage amount
				health_components.take_damage(bullet_damage) 
				if bullet_impact:
					var impact_show = bullet_impact.instantiate()
					impact_show.global_position = body.global_position
					get_parent().add_child(impact_show)

func apply_player_damage(area):
	if self.get_parent() is Player:
			if health_components.health > 0:
				var enemy_damage = %"Hurtbox Components".damage 
				health_components.take_damage(enemy_damage)
				FrameFreeze.hit_freeze()
	
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

	




