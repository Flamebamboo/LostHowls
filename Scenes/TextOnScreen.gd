extends CanvasLayer

#this class should and will contain all related gui like flash when player hurt enemy killed and stuff
@onready var anim_player = $AnimationPlayer


#show fps
@onready var fps_label := $FPSlabel

func _process(delta):
	fps_label.text = str("FPS ", Engine.get_frames_per_second())


func play_animation(animation_type: String):
	#self.visible = true
	anim_player.play(animation_type)
	await anim_player.animation_finished
	#self.visible = false
