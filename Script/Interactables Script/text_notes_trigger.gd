extends Area2D

	

	
func _ready() -> void:
	connect("area_entered", _entered_area)
	connect("area_exited", _exited_area)
	$"../TextureRect".hide()
	
func _entered_area(area_2d: Area2D) -> void:
	if area_2d.get_parent() is CharacterBody2D:
		$"../TextureRect".show()
	
func _exited_area(area_2d: Area2D) -> void:
	if area_2d.get_parent() is CharacterBody2D:
		$"../TextureRect".hide()
		
