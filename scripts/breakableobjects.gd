@tool
#tool is very powerfull, it allows the script to run in the editor 
#basically easier to edit and see changes without running the scene

#this scripts follows strategy design patterns the "BaseObjectStratergy" 
#contains the behaviours and properties of an object
#allowing for easier customization for different type of object
extends Area2D

@export var sprite : Sprite2D
@export var object_strategy : BaseObjectStrategy:
	
	set(val):
		object_strategy = val
		#needs_update = true

# Used when editing to denote that the sprite has changed and needs updating
@export var needs_update := false

@export var damage_amount : int = 5

func _ready() -> void:
	sprite.texture = object_strategy.beforedamage
	add_to_group("breakable objects")
func _process(delta: float) -> void:
	# This is run only when we're editing the scene
	if Engine.is_editor_hint():
		if needs_update:
			sprite.texture = object_strategy.beforedamage
			sprite.texture = object_strategy.afterdamage
			needs_update = false




func _on_area_entered(area):
	if area.is_in_group("bullet"):  
		object_damage(damage_amount)
	

func object_damage(damage: int):
	var current_health = object_strategy.object_damage(damage)	
	if current_health == 50:
		sprite.texture = object_strategy.afterdamage  # Update texture after damage
	if current_health <= 0:
		print(str(self), "current health is ", current_health)
		
		queue_free() 
	
	
	
	
	
	
	
