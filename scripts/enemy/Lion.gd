extends "res://scripts/enemy/baseEnemy.gd"

@export
var _moveSpeed:float=160
@export
var backToSideSpeedMult:float=0.25
@export
var pounceMult:float=1.5

@export 
var minDist:float = 80

@export
var maxDist:float = 120

@export
var LionSideOffset:Vector2 = Vector2(-50,0)

var LionTamer:Node2D=null	#TODO:When lion tamer dies, find a way to signal lion, and de-reference LionTamer

func setTamer(Tamer:Node2D):
	LionTamer=Tamer

func start(_Player, _maxHealth):
	moveSpeed=_moveSpeed

func _process(delta):
	super._process(delta)
	
func move(delta):
	var playerDist:float=Player.get_global_position().distance_to(LionTamer.get_global_position())
	var areaToReach:Vector2
	var finalMoveSpeed:float=moveSpeed
	
	if(playerDist>maxDist):	#Lion is too far away to chase player
		areaToReach=LionTamer.get_global_position()+LionSideOffset
		finalMoveSpeed *= backToSideSpeedMult;
	elif(playerDist<maxDist && playerDist > minDist):	#Lion can chase player, but cannot reach player
		areaToReach=get_global_position().direction_to(Player.get_global_position())*minDist + LionTamer.get_global_position()
	else:	#Lion can reach player
		areaToReach=Player.get_global_position()
	
func attack(delta):
	pass
