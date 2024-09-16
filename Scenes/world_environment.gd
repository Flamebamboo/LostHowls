extends WorldEnvironment

func _ready():
	Global.world_post_processing.connect(_world_post_processing)
	
func _world_post_processing(toggled_on):
	self.environment.glow_enabled = toggled_on
