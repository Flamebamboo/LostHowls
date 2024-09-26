extends BaseHealth
class_name EnemyHealth

@onready var Enemy: CharacterBody2D

func _ready():
	health = health_max

func _process(_delta):
	if !Global.dogAlive:
		health = health_max
		
