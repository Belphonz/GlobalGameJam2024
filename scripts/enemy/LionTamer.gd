extends "res://scripts/enemy/baseEnemy.gd"

@export
var _moveSpeed:float=40

var LionScene

var Lion:Node2D=null

func Start(_Player,_maxHealth,enemyID):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	#TODO:Instantiate Lion

func _process(delta):
	super._process(delta)
	
	
func move(delta):
	velocity=moveSpeed * playerDirection
	move_and_slide()
	
func attack(delta):
	pass
