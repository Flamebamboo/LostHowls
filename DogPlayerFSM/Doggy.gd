extends CharacterBody2D
class_name Player
@onready var jump_vfx = preload("res://art/VFX/jump_vfx.tscn")

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
	
	
func jump_effects():
	if jump_vfx:
		var jump_instance = jump_vfx.instantiate()
		if physics.velocity.x == 0:
			jump_instance.current_animation = "double"
			print("i am called but i dont work")
		else:
			jump_instance.current_animation = "landing"
			print("i am called but i dont work too")
		
		jump_instance.global_position = %landeffect.global_position
		print("position", jump_instance.global_position)
		get_tree().root.add_child(jump_instance)


func _on_air_state_not_active():
	jump_effects()

