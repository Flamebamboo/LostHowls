extends Area2D
class_name Hitbox

@export var damage: int = 0
@export var is_bullet: bool
@export var is_entity: bool
var is_shot: bool = false

func _ready():
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D):
	if area is Hurtbox: #(Hurtbox is class type area2d that is children to player or other enemy)
		var hurtbox: Hurtbox = area
		if is_bullet && !is_shot:
			area.apply_damage(damage)
			is_shot = true
			queue_free()
		if is_entity:
			area.apply_damage(damage)
		
		
