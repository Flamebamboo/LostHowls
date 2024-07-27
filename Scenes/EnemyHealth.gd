extends BaseHealth
class_name EnemyHealth

@onready var bossbat: BossBat

func _ready():
	health = health_max

func _process(delta):
	if !Global.dogAlive:
		health = health_max
		
