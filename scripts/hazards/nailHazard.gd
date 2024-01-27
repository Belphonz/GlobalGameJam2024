extends "res://scripts/hazards/baseHazard.gd"

func place(location:Vector2):
	super.place(location)

func destroy():
	super.destroy()

func collide(colliding:Node2D):
	super.collide(colliding)
