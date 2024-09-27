extends Control
@onready var timelabel: Label = $End/PanelContainer/MarginContainer/timelabel
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready():
	SoundManager.PlayEndScreen()
	animation.play("EndScreen")
	var current_time = Global.formatted_time
	print(current_time)
	timelabel.text = str("Completed Time: ", current_time)

func _process(delta: float) -> void:
	await animation.animation_finished
	get_tree().quit()
