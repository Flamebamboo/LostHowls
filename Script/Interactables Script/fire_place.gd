extends Area2D
@export var light: PointLight2D
@export var firecamp: AnimatedSprite2D 



func _ready():
	firecamp.play("no_fire")
	light.enabled = false      
	Global.lights_toggled.connect(on_light_toggled)

func on_light_toggled(toggled_on):
	light.enabled = toggled_on # value of true or false recieved from the button
	
	
func _on_body_entered(body):
	if body is Player:
		firecamp.play("fire")
		light.enabled = Global.light_setting
		CheckpointManager.add_checkpoint(global_position)
		
