extends "res://scripts/enemy/baseEnemy.gd"

@export
var _moveSpeed:float=40

@export
var lionMaxHealth=1

var lionAlive:bool=true

var Lion:Node2D=null #TODO:When lion dies, find a way to signal lion, and de-reference Lion

func Start(_Player,_maxHealth,enemyID):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	


func addLion(enemyID):
	Lion = preload("res://elements/enemies/Lion.tscn").instantiate()
	Lion.set_global_position(get_global_position()-Vector2(50,0))
	Lion.start(Player,lionMaxHealth)
	Lion.setTamer(self)
	Lion.name="Enemy Lion"+str(enemyID)
	get_parent().add_child(Lion)	#Add Lion to enemy manager

func freeTamer():	#Lion has died, do separate things for the tamer
	Lion=null
	lionAlive=false

func _process(delta):
	super._process(delta)
	
	
func move(delta):
	if(!lionAlive):
		return
	velocity+=moveSpeed * playerDirection
	move_and_slide()
	velocity=Vector2(0,0)
	
func attack(delta):
	pass
	
func OnDeath():
	Lion.freeLion()
	super.onDeath()
