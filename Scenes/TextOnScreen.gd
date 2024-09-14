extends CanvasLayer

#this class should and will contain all related gui like flash when player hurt enemy killed and stuff
@onready var anim_player = $AnimationPlayer

#show fps



func _ready():
	anim_player.play("RESET")

func _process(delta):
	esc_pressed()
	
	
	
	
	

func play_animation(animation_type: String):
	#self.visible = true
	anim_player.play(animation_type)
	await anim_player.animation_finished
	#self.visible = false
	
func esc_pressed():
	if Input.is_action_just_pressed("menu") && !get_tree().paused:
		anim_player.play("Open")
		get_tree().paused = true
	elif Input.is_action_just_pressed("menu") && get_tree().paused:
		get_tree().paused = false
		anim_player.play_backwards("Open")
		#anim_player.play("Close")
		
