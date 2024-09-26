extends Control

#this class should and will contain all related gui like flash when player hurt enemy killed and stuff
@onready var anim_player = $ScreenGUI/AnimationPlayer
@onready var colour_blind: ColorRect = $ScreenGUI/ColorBlind
@onready var fps: Label = $ScreenGUI/TopRightInfo/MarginContainer/VBoxContainer/FPSlabel

#show fps

enum MenuState { NONE, PAUSE_MENU, AUDIO_MENU, GRAPHIC_MENU }
var menu_state: MenuState = MenuState.NONE


func _ready():
	anim_player.play("RESET")
	Global.particle_setting = true
	Global.light_setting = true
	colour_blind.visible = false
	fps.visible = true
		
	

func _process(delta):
	PauseMenu()
	AudioMenu()
	GraphicMenu()

		
	

func play_animation(animation_type: String):
	#self.visible = true
	anim_player.play(animation_type)
	await anim_player.animation_finished
	#self.visible = false

#PauseMenu	
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
		
		
#Audio Menu
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
	if menu_state == MenuState.PAUSE_MENU:
		open_graphic_menu()
		
		
func open_graphic_menu():
	anim_player.play("GraphicOptions")
	await anim_player.animation_finished
	menu_state = MenuState.GRAPHIC_MENU
	
func close_graphic_menu():
	anim_player.play_backwards("GraphicOptions")
	await anim_player.animation_finished
	menu_state = MenuState.PAUSE_MENU

func GraphicMenu():
	if menu_state == MenuState.GRAPHIC_MENU && Input.is_action_just_pressed("esc"):
		close_graphic_menu()
	


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	close_pause_menu()


##graphic settings 



func _on_glow_buttom_toggled(toggled_on: bool) -> void:
	Global.world_post_processing.emit(toggled_on)


func _on_particles_button_toggled(toggled_on: bool) -> void:
	Global.particle_toggled.emit(toggled_on)
	Global.particle_setting = toggled_on


func _on_lightings_button_toggled(toggled_on: bool) -> void: #this function is called when the button is toggled
	Global.lights_toggled.emit(toggled_on) # this method calls the global function and passed bool value
	Global.light_setting = toggled_on


func _on_colour_blind_button_toggled(toggled_on: bool) -> void:
	colour_blind.visible = toggled_on


func _on_fps_button_toggled(toggled_on: bool) -> void:
	fps.visible = toggled_on 
