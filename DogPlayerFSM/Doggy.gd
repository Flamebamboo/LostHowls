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
	
func sprite_flash():
	var tween: Tween = create_tween()
	tween.tween_property(%AnimatedSprite2D, "modulate:v", 1, 0.25).from(15)
	

