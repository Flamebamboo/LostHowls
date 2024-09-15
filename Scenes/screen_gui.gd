extends CanvasLayer

#this class should and will contain all related gui like flash when player hurt enemy killed and stuff
@onready var anim_player = $AnimationPlayer

#show fps

enum MenuState { NONE, PAUSE_MENU, AUDIO_MENU }
var menu_state: MenuState = MenuState.NONE


func _ready():
	anim_player.play("RESET")
	
	

func _process(delta):
	PauseMenu()
	AudioMenu()

	

func play_animation(animation_type: String):
	#self.visible = true
	anim_player.play(animation_type)
	await anim_player.animation_finished
	#self.visible = false
	
func PauseMenu():
	if Input.is_action_just_pressed("esc"):
		if menu_state == MenuState.NONE:
			open_pause_menu()
		elif menu_state == MenuState.PAUSE_MENU:
			close_pause_menu()


func open_pause_menu():
	anim_player.play("MenuOpen")
	await anim_player.animation_finished
	get_tree().paused = true
	menu_state = MenuState.PAUSE_MENU
	print("works")

func close_pause_menu():
	anim_player.play_backwards("MenuOpen")
	await anim_player.animation_finished
	get_tree().paused = false
	menu_state = MenuState.NONE
		
	#else:
		#anim_player.play_backwards("MenuOpen")
		
		
#audio related

func _on_audio_pressed() -> void:
	if menu_state == MenuState.PAUSE_MENU:
		open_audio_menu()
		print("pressed audio button from paused menu")

		
		
func open_audio_menu():
	anim_player.play("AudioOptions")
	await anim_player.animation_finished
	menu_state = MenuState.AUDIO_MENU
	print("pressed audio button going to audio menu")
	# Don't unpause the game in audio menu, but keep track of the menu state

func AudioMenu():
	if menu_state == MenuState.AUDIO_MENU and Input.is_action_just_pressed("esc"):
		close_audio_menu()
		print("pressed esc from audio menu going to paused menu")
		

func close_audio_menu():
	anim_player.play_backwards("AudioOptions")
	await anim_player.animation_finished
	menu_state = MenuState.PAUSE_MENU
	print("pressed closed")


func _on_graphic_pressed() -> void:
	print("chelllelel")
	#to be made


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	close_pause_menu()
