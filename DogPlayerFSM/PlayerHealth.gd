extends BaseHealth
class_name PlayerHealth
@onready var player : Player
func _ready():
	health = PlayerStats.health

func take_damage(amount: int):
	if dead:
		return
	health -= amount
	PlayerStats.health = health
	if health < health_min:
		health = health_min
	emit_signal("took_damage")
	if health <= 0:
		handle_death()

func handle_death():
	dead = true
	PlayerStats.dead = true
	emit_signal("died")
