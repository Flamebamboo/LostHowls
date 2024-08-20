extends Node

var dogAlive: bool
var dogCharacter: CharacterBody2D
var dogFreeze: bool 

var BossBatAlive: bool
#current active state

var current_idle : bool
var current_jump: bool
var current_air: bool
var current_run: bool
var current_glide: bool


#func load_screen_to_scene(target: String, anim_name: String):
	#var loading_screen = preload("res://LevelTransition.tscn").instantiate()
	#loading_screen.next_scene_path = target
	#loading_screen.starting_anim_name = anim_name
	#get_tree().current_scene.add_child(loading_screen)	
	#
	#
