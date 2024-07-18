extends Node
class_name BaseHealth

var health: int
@export var health_max = 100

var health_min = 0
var taking_damage: bool

@export var CharacterBody : CharacterBody2D

signal took_damage()#hitflash, sound play
signal died() #send to play death animations 

func _ready():
	health = health_max
	

func _physics_process(_delta):
	if health <= 0:
		handle_death()
		
func take_damage(amount: int):
	health -= amount
	if health < health_min:
		health = health_min
		
	emit_signal("took_damage")
	if health <= 0:
		handle_death()
	
	
func handle_death():
	emit_signal("died")
	
	
	
