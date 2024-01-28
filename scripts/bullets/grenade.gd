extends Node2D

var damage : float
@export
var explodeRadius:float=50

@export
var damageEnemies:bool=true

@export 
var airTime:float=0.4	#how long object is thrown for

@export
var maxCurveHeight:float=20

@export
var fuseTime:float=3

@export
var explosionLifeTime:float=0.5

@export
var explosionSpriteSize:Vector2

var timeInAir:float=0

var startThrow:Vector2
var endThrow:Vector2

var fuseTimer:float=0

var explosionArea:Area2D

var explosionTime:float=0

enum state{throw,fuse,explode}

var bombState:state=state.throw

func throw(start:Vector2, end:Vector2):
	startThrow=start
	endThrow=end
	bombState=state.throw
	global_position=start

# Called when the node enters the scene tree for the first time.
func _ready():
	explosionArea=get_node("ExplosionArea")
	
	var CollisionShapeSize=explodeRadius / 10	#Set the size of the explosion area
	explosionArea.get_child(0).scale=Vector2(CollisionShapeSize,CollisionShapeSize)
	
	var explosionSprite:Node2D=get_node("explosion")
	var explosionSize=Vector2(explodeRadius / explosionSpriteSize.x,explodeRadius / explosionSpriteSize.y)
	explosionSprite.scale=explosionSize

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(bombState==state.throw):	#Bomb has been thrown and is flying through the air
		timeInAir+=delta
		if(timeInAir>airTime):
			bombState=state.fuse
			set_global_position(endThrow)
			return
		var pointInCurve:float = timeInAir/airTime
		var position:Vector2 = lerp(startThrow,endThrow,pointInCurve)
			
		var yOffset:float=pointInCurve*-4.0*maxCurveHeight*(1.0-pointInCurve)	#Calculate y offset to add for curve
		position.y+=yOffset
			
		set_global_position(position)
		return
	if(bombState==state.fuse):	#Bomb is on the floor and is ticking down
		fuseTimer+=delta
		if(fuseTimer>fuseTime):
			bombState=state.explode
			explode()
			get_node("explosion").visible = true #TODO: Add actual explosion animation
	if(bombState==state.explode):
		explosionTime+=delta
		if(explosionTime>explosionLifeTime):
			queue_free()
	

func explode():
	var allArea2Ds:Array=explosionArea.get_overlapping_areas()
	for area in allArea2Ds:
		if(area.name=="EnemyCollider" && damageEnemies):	#Hit enemy
			area.get_parent().HP-= damage
		if(area.name=="PlayerCollider"):	#Hit player
			if(!area.get_parent().iFramesActive):
				area.get_parent().HP-= damage
				area.get_parent().iFramesActive=true
	
