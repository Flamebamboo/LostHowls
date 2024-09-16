extends GPUParticles2D

func _ready():
	Global.particle_toggled.connect(_on_particle_toggled)

func _on_particle_toggled(toggled_on):
	self.emitting = toggled_on
