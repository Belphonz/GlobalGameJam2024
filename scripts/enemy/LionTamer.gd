extends "res://scripts/enemy/baseEnemy.gd"

@export
var _moveSpeed:float=40

@export
var lionMaxHealth=1

var Lion:Node2D=null

func Start(_Player,_maxHealth,enemyID):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	
	Lion = preload("res://elements/enemies/Lion.tscn").instantiate()
	Lion.set_global_position(get_global_position()-Vector2(50,0))
	Lion.name="Enemy Lion"+(enemyID+1)
	Lion.start(_Player,lionMaxHealth)

func _process(delta):
	super._process(delta)
	
	
func move(delta):
	velocity=moveSpeed * playerDirection
	move_and_slide()
	
func attack(delta):
	pass
