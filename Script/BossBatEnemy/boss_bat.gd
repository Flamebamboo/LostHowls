extends CharacterBody2D
class_name BossBat
@export var camera: Camera2D
@export var hitflashing: AnimationPlayer
@export var health_component : EnemyHealth
@export var hurtbox_component: Hurtbox
@export var animatedsprite : AnimatedSprite2D
@onready var machine = %BossBatFSM






func _ready():
	animatedsprite.play("flying")
	
	
func _physics_process(_delta):
	move_and_slide()
	if !Global.dogAlive:
		machine.transition_to(machine.states["SleepState"])
	var state_name = machine.active_state.get_name()
	$Label.text = state_name	

func _on_health_components_took_damage():
	$ProgressBar.value = health_component.health
	var tween: Tween = create_tween()
	tween.tween_property(animatedsprite, "modulate:v", 1, 0.25).from(15)
	await get_tree().create_timer(0.1).timeout
	animatedsprite.play("flying")
	camera.apply_shake(20.0, 10.0)
	
	
	


func _on_health_components_died():
	camera.apply_shake(200.0, 100.0)
	await get_tree().create_timer(1).timeout
	hitflashing.blue_flash()
	queue_free()

	




