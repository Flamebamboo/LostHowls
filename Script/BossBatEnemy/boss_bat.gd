extends CharacterBody2D
class_name BossBat
@export var camera: Camera2D
@export var health_component : EnemyHealth
@export var hurtbox_component: Hurtbox
@export var animatedsprite : AnimatedSprite2D
@onready var machine = %BossBatFSM
@onready var progress_bar: TextureProgressBar = $CanvasLayer/PanelContainer/ProgressBar

signal BossBatDeath




func _ready():
	animatedsprite.play("flying")
	Global.BossBatAlive = true
	progress_bar.visible = false
func _physics_process(_delta):
	move_and_slide()
	if !Global.dogAlive:
		machine.transition_to(machine.states["SleepState"])
		progress_bar.visible = false
	#var state_name = machine.active_state.get_name()
	#$Label.text = state_name	

func _on_health_components_took_damage():
	progress_bar.value = health_component.health
	var tween: Tween = create_tween()
	tween.tween_property(animatedsprite, "modulate:v", 1, 0.25).from(15)
	await get_tree().create_timer(0.1).timeout
	animatedsprite.play("flying")
	camera.apply_shake(20.0, 10.0)
	progress_bar.visible = true
	
	
	


func _on_health_components_died():
	camera.apply_shake(200.0, 100.0)
	await get_tree().create_timer(1).timeout
	Global.BossBatAlive = false
	emit_signal("BossBatDeath")
	progress_bar.visible = false
	queue_free()

	
