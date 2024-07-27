extends StaticBody2D

func _ready():
	$CollisionShape2D.disabled = true
	

func _process(delta):
	if Global.dogAlive:
		$CollisionShape2D.disabled = true


func _on_area_2d_body_exited(body):
	await get_tree().create_timer(2).timeout
	$CollisionShape2D.disabled = false
