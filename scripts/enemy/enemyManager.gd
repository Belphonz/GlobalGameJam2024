extends Node

var Player: Node2D

var cAK47 = preload("res://elements/enemies/ClownWithAK47.tscn")

@export
var CAK47MoveSpeed:float

var EnemyID = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Player=get_node("../Player")
	spawnClownAK47(Vector2(100,100))
	#spawnRingmaster(Vector2(100,100))
	
	
func spawnClownAK47(position:Vector2):
	var enemyInstanceNode:CharacterBody2D = preload("res://elements/enemies/ClownWithAK47.tscn").instantiate()
	enemyInstanceNode.set_global_position(position)
	enemyInstanceNode.start(Player,1)
	EnemyID += 1
	enemyInstanceNode.name = "Enemy ClownAK47" + str(EnemyID)
	add_child(enemyInstanceNode)
	
func spawnRingmaster(position:Vector2):
	var enemyInstanceNode:CharacterBody2D = preload("res://elements/enemies/ringmaster.tscn").instantiate()
	enemyInstanceNode.set_global_position(position)
	enemyInstanceNode.start(Player,1)
	EnemyID += 1
	enemyInstanceNode.name = "Enemy Ringmaster" + str(EnemyID)
	add_child(enemyInstanceNode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
