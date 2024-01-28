extends Node2D

@export 
var airTime:float=0.4	#how long object is thrown for

@export
var maxCurveHeight=20

var timeInAir:float=0

var startThrow:Vector2
var endThrow:Vector2

var active:bool=true

func throw(startLocation:Vector2,endLocation:Vector2):
	active=true
	global_position=startLocation
	startThrow = startLocation
	endThrow=endLocation


# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = randf_range(-180,180)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		if(active):	#Move the bell in an arc
			timeInAir+=delta
			if(timeInAir>airTime):
				active=false
				set_global_position(endThrow)
				
				return
			var pointInCurve:float = timeInAir/airTime
			var position:Vector2 = lerp(startThrow,endThrow,pointInCurve)
			
			var yOffset:float=pointInCurve*-4.0*maxCurveHeight*(1.0-pointInCurve)	#Calculate y offset to add for curve
			position.y+=yOffset
			
			set_global_position(position)
			return

	
func _on_area_2d_area_entered(area):
	if(!active):
		return
	if(area.name=="PlayerCollider"):
		var Player:Node2D=area.get_parent()
		Player.HP-=1
		
