extends CharacterBody2D 
class_name MiniBat

@export var camera: Camera2D
@export var health_component := BaseHealth
@export var hurtbox_component:= Hurtbox
@onready var machine := %MiniBatFSM
@export var animatedsprite: AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func ready():
	animation_player.play("RESET")
	$AnimationPlayer.play("off")
func _physics_process(_delta):
	move_and_slide()
	
	
	var state_name = machine.active_state.get_name()
	#$Label.text = state_name	
	
func _on_health_components_took_damage():
	pass
	var tween: Tween = create_tween()
	tween.tween_property(animatedsprite, "modulate:v", 1, 0.25).from(15)
	await get_tree().create_timer(0.1).timeout
	animatedsprite.play("flying")
	camera.apply_shake(20.0, 10.0)
	

func _on_health_components_died():
	camera.apply_shake(20.0, 10.0)
	var tween = get_tree().create_tween()
	tween.tween_callback(animatedsprite.set_modulate.bind(Color.RED)).set_delay(2)
	await get_tree().create_timer(1).timeout
	queue_free()
