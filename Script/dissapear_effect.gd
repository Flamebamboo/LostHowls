extends Node2D

@onready var landing_effects: AnimatedSprite2D = %landing_effect
@onready var double_effect: AnimatedSprite2D = %double_effect
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var animation_list: PackedStringArray = animation_player.get_animation_list()
var current_animation: String = "landing"


func _physics_process(_delta):
	if current_animation in animation_list:
		animation_player.play(current_animation)
	


func _on_landing_effect_animation_finished():
	self.queue_free()


func _on_double_effect_animation_finished():
	self.queue_free()
