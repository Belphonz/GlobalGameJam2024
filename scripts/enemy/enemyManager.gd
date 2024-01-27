extends Node

var Player: Node2D

var cAK47 = preload("res://elements/enemies/ClownWithAK47.tscn")

@export
var CAK47MoveSpeed:float



# Called when the node enters the scene tree for the first time.
func _ready():
	Player=get_node("../Player")
	spawnClownAK47(Vector2(100,100))
	
	
func spawnClownAK47(position:Vector2):
	var enemyInstanceNode=cAK47.instantiate()
	enemyInstanceNode.set_global_position(position)
	enemyInstanceNode.start(Player,1)
	add_child(enemyInstanceNode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
