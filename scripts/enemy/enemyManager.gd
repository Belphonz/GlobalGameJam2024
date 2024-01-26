extends Node

@export
var Player: Node2D

var ClownWithAK47 : = preload("res://elements/enemies/ClownWithAK47.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	if(Player==null):
		print("Normal print")
	Player=get_node("../Player")
	if(Player==null):
		print("Uh oh")
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(Player.get_global_position())
