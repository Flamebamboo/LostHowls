extends Area2D
class_name Hurtbox
@export var health_components: BaseHealth
@export var damage = 1
#bullet impact vfx scene export here 

@export var bullet_impact: PackedScene

func _ready():
	pass

func _physics_process(_delta):
	for body in %"Hurtbox Components".get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(damage)
			break
				
	
	#this func will take bullet as a argument to check if classname health, health is > 0
	#all other common sense logic
	
func _on_body_entered(body):
	if body.is_in_group("bullet"):
		apply_bullet_damage(body)
	
	elif body.is_in_group("Enemy"):
		apply_enemy_damage(body)
	
						
		#since hurtbox component is a shared functionality between enemies and player
		# we have to differentiate them and only apply bullet damages to Enemy	

			
			
		
	#instance bullet impact scene here
	#change in health signal 
	
func apply_bullet_damage(body):
	if self.get_parent() is BossBat: #checking the owner of the hurtbox if it has group enemy
			if health_components.health > 0: #if both of this conditions are met damage will be applied to health components
				var bullet_damage = body.damage #body.damage is from the bullet damage amount
				health_components.takedamage(bullet_damage) 
				if bullet_impact:
					var impact_show = bullet_impact.instantiate()
					impact_show.global_position = body.global_position
					get_parent().add_child(impact_show)

func apply_enemy_damage(body):
	if self.get_parent() is Player:
			if health_components.health > 0:
				var enemy_damage = body.damage 
				health_components.takedamage(enemy_damage)
