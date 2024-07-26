extends Area2D

@export var timeline:DialogicTimeline


	
func _on_body_entered(body):
	if body is Player:
		Dialogic.timeline_ended.connect(ended)
		Dialogic.start(timeline)
		Global.dogFreeze = true


func ended():
	Dialogic.timeline_ended.disconnect(ended)
	Global.dogFreeze = false
