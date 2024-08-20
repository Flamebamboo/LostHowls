extends CanvasLayer
@onready var anim_player = $Control/AnimationPlayer

func _ready():
	anim_player.play("FindYourOwnerHide")



func _on_radiotape_subtitles_ui():
	anim_player.play("RadioTapeOne")
