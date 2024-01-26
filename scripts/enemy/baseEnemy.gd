extends Node2D

var Player=null		#Node2D

var health		#Float
var maxHealth	#Float

func start(player):	#When enemy is created, add all 
	player=Player
	
func move():	#Overwrite to add specific enemy movement
	pass
	
func spawnObject():	 #Acts as shooting
	pass

func GetHurt(damage):
	pass

func onDeath():
	pass
