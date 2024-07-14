extends Node
class_name BaseHealth

var health: int
@export var health_max = 1

var health_min = 0
var taking_damage: bool
var dead: bool
@export var CharacterBody : CharacterBody2D

signal took_damage()#hitflash, sound play
signal died() #send to play death animations 

func _ready():
	health = health_max
	

func _physics_process(_delta):
	if health <= 0:
		handledeath()
		
func takedamage(amount: int):
	if dead:
		return
	health -= amount
	if health < health_min:
		health = health_min
		
	emit_signal("took_damage")
	if health <= 0:
		handledeath()
	
	
func handledeath():
	dead = true
	emit_signal("died")
	
	
	
