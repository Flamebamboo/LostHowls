extends PanelContainer
var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0


@onready var fps_label: Label = $MarginContainer/VBoxContainer/FPSlabel
func _ready() -> void:
	visible = false
func _process(delta: float) -> void:
	if Global.game_start:
		visible = true
		fps_label.text = str("FPS ", Engine.get_frames_per_second())
		#stopwatch
		time += delta
		msec = fmod(time, 1) * 100
		seconds = fmod(time, 60)
		minutes = fmod(time, 3600) / 60
		$MarginContainer/VBoxContainer/HBoxContainer/minutes.text = "%02d:" % minutes
		$MarginContainer/VBoxContainer/HBoxContainer/seconds.text = "%02d." % seconds
		$MarginContainer/VBoxContainer/HBoxContainer/Msecs.text = "%03d" % msec
	
	if Global.game_finished:
		stoptimer()
		visible = false



func stoptimer() -> void:
	set_process(false)
	Global.formatted_time = get_time_formatted()
	
func get_time_formatted() -> String:
	return "%02d:%02d.%03d" % [minutes, seconds, msec]
	
 #if lter game finishes print this formatted time on win screen.
