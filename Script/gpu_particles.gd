extends GPUParticles2D
#
func _ready():
	Global.particle_toggled.connect(_on_particle_toggled)
	self.emitting = Global.particle_setting
	
func _on_particle_toggled(toggled_on):
	self.emitting = toggled_on
