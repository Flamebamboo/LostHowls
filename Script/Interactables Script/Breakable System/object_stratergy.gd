
extends Resource
class_name BaseObjectStrategy
@export var beforedamage : Texture2D
@export var afterdamage : Texture2D
@export var health : int = 100

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func object_damage(damage: int):
	health -= damage
	print("Health after damage:", health)
	return health 


# Strategy Relevant Code:
# This is the base strategy that all other
# object strategies will inherit from.
