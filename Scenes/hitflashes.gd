extends AnimationPlayer
@onready var sprite = $Sprite2D
@onready var color = $ColorRect


func _ready():
	color.visible = false
	sprite.visible = false

func blue_flash():
	color.visible = true
	sprite.visible = true
	self.play("hit_flashes")
	
