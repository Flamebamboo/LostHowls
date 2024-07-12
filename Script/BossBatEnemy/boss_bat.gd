extends CharacterBody2D
class_name BossBat
@export var health : Health 
@export var hurtbox: Hurtbox
@export var animatedsprite : AnimatedSprite2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animatedsprite.play("idle")
	
	
func _physics_process(delta):
	
	#apply_gravity(delta)
	
	move_and_slide()
	
#func apply_gravity(delta):
	#if not is_on_floor():
		#velocity.y += gravity * 30 * delta


func _on_health_components_took_damage():
	$ProgressBar.value = health.health
	animatedsprite.play("hurt")
	await get_tree().create_timer(0.1).timeout
	animatedsprite.play("flying")
	
	
	
	pass #play hit sound, hitflash


func _on_health_components_died():
	self.queue_free()
