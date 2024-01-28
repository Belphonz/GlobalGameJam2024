extends Node2D

@export
var explodeRadius:float=50

var explosionArea:Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var explosionArea=get_node("ExplosionArea")
	
	var CollisionShapeSize=explodeRadius / 10	#Set the size of the explosion area
	explosionArea.get_child(0).scale=Vector2(CollisionShapeSize,CollisionShapeSize)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func explode():
	var allArea2Ds:Array=explosionArea.get_overlapping_areas()
	for area in allArea2Ds:
		if()
