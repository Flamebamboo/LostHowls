extends CharacterBody2D
class_name Player
@export var anim: AnimatedSprite2D
@onready var machine = %PlayerStateMachine
@export var gravity = 30
@export var terminal_velocity = 1000
@export var jump_velocity = 600
@export var air_resistance = 0.15
@export var run_speed = 300
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

	velocity.y = min(velocity.y, terminal_velocity)
	velocity.y += gravity
	move_and_slide()


func _on_health_components_took_damage():
	%ProgressBar.value = health_component.health


func _on_health_components_died():
	self.queue_free()
