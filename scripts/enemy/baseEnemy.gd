extends CharacterBody2D

var Player:Node2D=null		#Node2D
var playerDirection: Vector2

var health:float
var maxHealth:float	

var moveSpeed: float

func start(_Player, _maxHealth):	#When enemy is created, add all 
	Player=_Player
	maxHealth=_maxHealth
	
	
func move(delta):	#Overwrite to add specific enemy movement
	pass
	
func attack(delta):	 #Acts as shooting
	pass
	
func _process(delta):
	playerDirection=(Player.get_global_position()-get_global_position()).normalized()
	
	attack(delta)
	move(delta)

func GetHurt(damage:int):
	pass

func onDeath():
	pass
