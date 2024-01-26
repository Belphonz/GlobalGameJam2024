extends Node2D

var Player:Node2D=null		#Node2D

var health:float
var maxHealth:float	

var actionRate: float

var moveSpeed: float

func start(_Player, _maxHealth, _actionRate, _moveSpeed):	#When enemy is created, add all 
	Player=_Player
	maxHealth=_maxHealth
	actionRate=_actionRate
	moveSpeed=_moveSpeed
	
func move():	#Overwrite to add specific enemy movement
	pass
	
func spawnObject():	 #Acts as shooting
	pass
	
func _process(delta):
	pass

func GetHurt(damage:int):
	pass

func onDeath():
	pass

