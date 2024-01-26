extends "res://scripts/enemy/baseEnemy.gd"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	print("Inherited print")

func start(_Player, _maxHealth, _moveSpeed):
	super.start(_Player,_maxHealth,_moveSpeed)
