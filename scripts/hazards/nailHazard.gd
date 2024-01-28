extends "res://scripts/hazards/baseHazard.gd"

@export 
var airTime:float=0.4	#how long object is thrown for


var damage:float = 3
@export
var maxCurveHeight=10

var timeInAir:float=0

var startThrow:Vector2
var endThrow:Vector2

func _ready():
	name="NailHazard"

func throw(start:Vector2, location:Vector2):
	active=false
	startThrow = start
	global_position=start
	endThrow=location

func _process(delta):
	if(!active):	#Being thrown
		timeInAir+=delta	
		if(timeInAir>airTime):	#Landed
			active=true
			place(endThrow)
			return
			
		var pointInCurve:float=timeInAir/airTime	#How far in the curve from 0-1
		var position:Vector2=lerp(startThrow,endThrow,pointInCurve)
		
		var yOffset:float=pointInCurve*-4.0*maxCurveHeight*(1.0-pointInCurve)	#Calculate y offset to add for curve
		position.y+=yOffset
		
		set_global_position(position)

func place(location:Vector2):
	super.place(location)

func destroy():
	super.destroy()

func collide(colliding:Node2D):
	if(!active):
		return
	super.collide(colliding)
	if(colliding.name=="PlayerCollider"):
		var Player:Node2D=colliding.get_parent()
		if(!Player.iFramesActive):
			Player.HP-= damage
			Player.iFramesActive=true
	if(colliding.name=="EnemyCollider"):
		var Enemy:Node2D = colliding.get_parent()
		print(Enemy.name)
		if !("Jester" in Enemy.name):
			Enemy.HP-= damage


func _on_area_entered(area):
	collide(area)
