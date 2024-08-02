extends CharacterBody2D 
class_name MiniBat

@export var camera: Camera2D
@export var hitflashing: AnimationPlayer
@export var health_component : BaseHealth
@export var hurtbox_component: Hurtbox

@export var animatedsprite: AnimatedSprite2D

func _physics_process(_delta):
	move_and_slide()




	
	




func _on_base_health_died():
	var tween: Tween = create_tween()
	tween.tween_property(animatedsprite, "modulate:v", 1, 0.25).from(15)
	await get_tree().create_timer(0.1).timeout
	animatedsprite.play("flying")
	camera.apply_shake(20.0, 10.0)


func _on_base_health_took_damage():
	camera.apply_shake(200.0, 100.0)
	await get_tree().create_timer(1).timeout
	hitflashing.blue_flash()
	queue_free()

