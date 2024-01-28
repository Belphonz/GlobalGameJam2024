extends "res://scripts/enemy/baseEnemy.gd"

@export
var _moveSpeed:float=160
@export
var backToSideSpeedMult:float=0.25
@export
var pounceMult:float=1.5

@export
var pounceDist:float = 60

@export 
var minDist:float = 120

@export
var maxDist:float = 150

@export
var LionSideOffset:Vector2 = Vector2(-50,0)

var LionTamer:Node2D=null	#TODO:When lion tamer dies, find a way to signal lion, and de-reference LionTamer

var tamerAlive:bool=true

func setTamer(Tamer:Node2D):
	LionTamer=Tamer

func start(_Player, _maxHealth):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	
func freeLion():
	LionTamer=null
	tamerAlive=false

func _process(delta):
	super._process(delta)
	if HP <= 0:
		onDeath()
	
func move(delta):
	
	var areaToReach:Vector2
	var finalMoveSpeed:float=moveSpeed
	
	if(tamerAlive):	#If the tamer is still alive
		var playerDist:float=Player.get_global_position().distance_to(LionTamer.get_global_position())
		if(playerDist>maxDist):	#Lion is too far away to chase player
			areaToReach=LionTamer.get_global_position()+LionSideOffset
			finalMoveSpeed *= backToSideSpeedMult;
		elif(playerDist<maxDist && playerDist > minDist):	#Lion can chase player, but cannot reach player
			areaToReach=get_global_position().direction_to(Player.get_global_position())*minDist + LionTamer.get_global_position()
		else:	#Lion can reach player
			areaToReach=Player.get_global_position()
			
	else:	#Tamer has died
		areaToReach=Player.get_global_position()
		
	if(get_global_position().distance_to(Player.get_global_position())):	#If lion should pounce
		finalMoveSpeed *= pounceMult
		
	var directionToMove:Vector2 = get_global_position().direction_to(areaToReach)
	velocity=directionToMove * finalMoveSpeed
	
	move_and_slide()

	
func attack(delta):
	pass
	
func onDeath():
	if LionTamer:
		LionTamer.freeTamer()
	var Blood : Node2D = BloodSplat.instantiate()
	Blood.global_position = global_position
	get_parent().get_parent().get_node("BloodsplatterNode").add_child(Blood)
	queue_free()		


func _on_enemy_collider_area_entered(area):
	if "PlBullet" in area.owner.name:
		HP -= 1
		var Bullet:Node2D=area.get_parent()
		Bullet.death()
