extends "res://scripts/enemy/baseEnemy.gd"

var Bullet:Node2D
@export
var attackSpeed:float=0.2
@export
var _moveSpeed:float = 0.5

var attackTimer:float=0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	

func start(_Player, _maxHealth):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	
func attack(delta):	#Function called every frame
	attackTimer+=delta
	if(attackTimer>=attackSpeed):
		attackTimer=0
		print("Test")		#TODO: Add shooting bullet
