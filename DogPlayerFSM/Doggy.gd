extends CharacterBody2D
class_name Player
@onready var jump_dust_effect_scene = preload("res://art/VFX/jump_vfx.tscn")

@export var anim: AnimatedSprite2D
@onready var machine = %PlayerStateMachine

@export var physics : PhysicsComponent
@export var health_component : PlayerHealth
@export var hurtbox_component: Hurtbox


@export var camera: Camera2D
var input_axis = 0

func _ready():
	Global.dogCharacter = self
	Global.dogAlive = true
func _physics_process(_delta):
	input_axis = Input.get_axis("moveleft", "moveright")
	if Global.dogAlive:
		if input_axis == 1:
			anim.flip_h = false
			
		elif input_axis == -1:
			anim.flip_h = true
			
	
	
	var state_name = machine.active_state.get_name()
	$Label.text = state_name



	
func sprite_flash():
	var tween: Tween = create_tween()
	tween.tween_property(%AnimatedSprite2D, "modulate:v", 1, 0.25).from(15)


func display_jump_effects():
	if jump_dust_effect_scene:
		var jump_dust_effect = jump_dust_effect_scene.instantiate()
		
		#if physics.velocity.x == 0:
			#jump_dust_effect.current_animation = "landing"
		##else:
			#jump_dust_effect.current_animation = "landing"
		print(jump_dust_effect.current_animation)
		jump_dust_effect.global_position = %landeffect.global_position
		get_tree().root.add_child(jump_dust_effect)
			

func instantdeath():
	health_component.health = health_component.health_min
	Global.dogAlive = false
	



func _on_air_state_floor():
	display_jump_effects()
