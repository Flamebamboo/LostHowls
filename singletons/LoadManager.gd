extends Node
#singleton created this algorithm following the godot background loading documentation
#using ResourceLoader to make it more scalable

#A singleton is a programming technique that allows you to use class name 
#to access properties and methods without instantiating copy of 

#why load scene previously is not a good approach? well as the game grows bigger it can cause unresponsive
#thats because the load function blocks the main thread till the scene is loaded
#so to fix this issue we use a loading screen


#this loading scene starts to load the new scene in a seperate thread using the
#load_threaded_request(next_scene_path)
#3 while the scene is loading in the background we can use the function..
#load_threaded_get_status(scene_name,progress)
#to check how much of the new scene has been loaded to update the progress value in the loading screen

#refering to the the doccumentations ThreadLoadStatus returns a enum value the value 1 means its still loading
#the value of 2 is failed and 3 is finised

	

signal progress_changed(progress)
signal load_done

var load_screen_path : String = "res://Scenes/LevelTransition.tscn"
var load_screen = load(load_screen_path)
var loaded_resource: PackedScene
var scene_path: String
var progress: Array = []

var use_sub_threads: bool = true

func load_scene(load_scene_path: String, anim_type: String):
	scene_path = load_scene_path
	
	var new_loading_screen = load_screen.instantiate()
	get_tree().get_root().add_child(new_loading_screen)
	
	new_loading_screen.play_animation(anim_type) #tryna pass the animation type
	
	
	
	self.progress_changed.connect(new_loading_screen.update_progress_bar)
	self.load_done.connect(new_loading_screen.start_outro_animation)
	
	await Signal(new_loading_screen, "loading_screen_has_full_coverage")
	
	start_load()
	
func start_load():
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)
		
func _process(_delta):
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	match load_status:
		0,2: #? THREAD_LOAD_INVALID_RESOURCE, THREAD_LOAD_FAILED
			set_process(false)
			return
			
		1: #? THREAD_LOAD_IN_PROGRESS
			emit_signal("progress_changed", progress[0])
		3: #? THREAD_LOAD_LOADED
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			emit_signal("progress_changed", 1.0)
			emit_signal("load_done")
			if get_tree():
				get_tree().change_scene_to_packed(loaded_resource)
			
	
	
	
	
	
	
	
	
	
	
	
	
