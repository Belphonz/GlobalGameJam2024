extends "res://scripts/enemy/baseEnemy.gd"

@export
var _moveSpeed:float = 90

func _process(delta):
	super._process(delta)
	
func start(_Player, _maxHealth):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	
func attack(delta):
	pass
	
func bounce():
	pass
	
func move(delta):
	var distFromPlayer:float=(Player.get_global_position().distance_to(get_global_position()))
	
