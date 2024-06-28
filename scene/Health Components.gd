extends Node
class_name Health

var health: int
@export var healthMax = 200

var healthMin = 0
var takingDamage: bool
var dead: bool
@export var CharacterBody : CharacterBody2D

signal tookDamage()#hitflash, sound play
signal died() #send to play death animations 

func _ready():
	health = healthMax
	

func _physics_process(delta):
	if health <= 0:
		handledeath()
		
func takedamage(amount: int):
	if dead:
		return
	health -= amount
	if health < healthMin:
		health = healthMin
		
	emit_signal("tookDamage")
	if health <= 0:
		handledeath()
	
	
func handledeath():
	dead = true
	emit_signal("died")
	
	
	
