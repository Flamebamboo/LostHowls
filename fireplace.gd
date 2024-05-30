extends Area2D
	
func _ready() -> void:
	$"..".play("no_fire")
	$"../Firelight/Sprite2D".visible = false
	connect("area_entered", _entered_area)
	connect("area_exited", _exited_area)
	

func _entered_area(area_2d: Area2D) -> void:
	if area_2d.get_parent() is CharacterBody2D:
		$"..".play("fire")
		$"../Firelight/Sprite2D".visible = true
func _exited_area(area_2d: Area2D) -> void:
	if area_2d.get_parent() is CharacterBody2D:
		pass



		
		
		
