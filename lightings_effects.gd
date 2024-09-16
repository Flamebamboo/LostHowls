extends PointLight2D

func _ready():         
	Global.lights_toggled.connect(on_light_toggled)

func on_light_toggled(toggled_on):
	self.enabled = toggled_on
