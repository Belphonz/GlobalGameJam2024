extends Area2D

var active:bool = false

func place(location:Vector2):
	set_global_position(location)
	active=true
	
func destroy():
	pass
	
func collide(colliding:Node2D):
	pass
