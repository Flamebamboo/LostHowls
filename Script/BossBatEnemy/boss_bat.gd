extends CharacterBody2D
class_name BossBat
#@export var camera: Camera2D
#@export var hitflashing: AnimationPlayer
@export var health_component : EnemyHealth
@export var hurtbox_component: Hurtbox
@export var animatedsprite : AnimatedSprite2D
@onready var machine = %BossBatFSM



var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_player : bool = true
func _ready():
	animatedsprite.play("flying")
	
	
func _physics_process(_delta):
	move_and_slide()
	print(self.global_position)


func _on_health_components_took_damage():
	$ProgressBar.value = health_component.health
	#var tween: Tween = create_tween()
	#tween.tween_property(animatedsprite, "modulate:v", 1, 0.25).from(15)
	await get_tree().create_timer(0.1).timeout
	animatedsprite.play("flying")
	
	
	


func _on_health_components_died():
	#camera.apply_shake(200.0, 100.0)
	await get_tree().create_timer(1).timeout
	#hitflashing.blue_flash()
	self.queue_free()
	
