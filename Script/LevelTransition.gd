extends CanvasLayer
#checklist 
#fade_from_black done
#fade_in done
#game_intro 

#next thing to implement (if have time)
#randomize label text displayed on load maybe some tips appear?
#might need to readjust the delay for this becuz if the loaded scene is quick users cant read the tips 

signal loading_screen_has_full_coverage
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var progress_bar : ProgressBar = $Control/ProgressBar


func update_progress_bar(new_value: float): 
	await get_tree().create_timer(1).timeout #slight delay idk just testing maybe leave it for now 
	progress_bar.set_value_no_signal(new_value * 100) #progress bar need to time 100 to fit the max value format

func play_animation(anim_type: String): #string anim is called in the load manager with passed animation type
	if animation_player.has_animation(anim_type):
		animation_player.play(anim_type)
	
		
func start_outro_animation(): #being called in the loadmanger
	await Signal(animation_player, "animation_finished")
	self.queue_free()
