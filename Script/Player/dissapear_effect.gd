extends Node2D

@onready var animation_player: AnimationPlayer =  $AnimationPlayer
@onready var animation_list: PackedStringArray = animation_player.get_animation_list()
var current_animation: String = "double"

func _ready():	
	if current_animation in animation_list:
		animation_player.play(current_animation)
		
	else:
		push_error("The animation {name} does not exists on the animation player list".format({"name": current_animation}))

##CURRENTLY BROKEN get_animation_list() from AnimationMixer seems to not work ;(

#deleted other effects aswell for now
#I wanted to have only one scene that manages various types of effect 
#instead of heaving each effect preloaded on its own but seems like its not working as expected 
