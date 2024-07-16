extends CharacterBody2D
class_name Player
@export var anim: AnimatedSprite2D
@onready var machine = %PlayerStateMachine

@export var physics : PhysicsComponent
@export var health_component : PlayerHealth
@export var hurtbox_component: Hurtbox
func _ready():
	Global.dogCharacter = self

func _physics_process(_delta):
	var direction = Input.get_axis("moveleft", "moveright")
	if direction == 1:
		anim.flip_h = false
	elif direction == -1:
		anim.flip_h = true
	
	if machine.active_state.can_fall:
		physics.velocity.y = min(physics.velocity.y, physics.terminal_velocity)
		physics.velocity.y += physics.gravity


		
func _on_health_components_took_damage():
	%ProgressBar.value = health_component.health


func _on_health_components_died():
	self.queue_free()
