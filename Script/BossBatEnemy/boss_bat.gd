extends CharacterBody2D
class_name BossBat
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
	


func _on_health_components_took_damage():
	$ProgressBar.value = health_component.health
	animatedsprite.play("hurt")
	await get_tree().create_timer(0.1).timeout
	animatedsprite.play("flying")
	
	
	
	pass #play hit sound, hitflash


func _on_health_components_died():
	self.queue_free()
