class_name Areabox
extends Area2D

signal hitdog

@onready var launch : Playerlauncher = get_owner()


func _ready():
	pass


		
	


func _on_body_entered(body):
	pass
	#if body is dog then dmit signal and pass knockback data
