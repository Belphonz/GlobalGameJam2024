extends Node

@export	#Variables to do with picking an enemy to spawn
var clownAK47Chance:float=1
@export
var clownChance:float=1
@export
var jesterChance:float=1
@export
var LionTamerChance:float=1
@export
var ringMasterChance:float=1

var sumChances:float

var chanceRanges:Array

@export	#Size of the ring
var ringSize:float=520

@export	#How many enemies per wave
var enemiesPerWave:float=5

@export 
var enemySpawnTime:float=0.4
var enemySpawnTimer:float=0

var enemiesToSpawn:int=0

var EnemyManager:Node2D

var rng=RandomNumberGenerator.new()	#rng

# Called when the node enters the scene tree for the first time.
func _ready():
	sumChances=clownAK47Chance+clownChance+jesterChance+LionTamerChance+ringMasterChance
	EnemyManager=get_parent().get_node("EnemyManager")
	
	for i in 5:
		chanceRanges.append(0.0)
	
	var chanceArray:Array=[clownAK47Chance,clownChance,jesterChance,LionTamerChance,ringMasterChance]	#Put data into array to make it iterable
	
	for i in 5:	#Make the chance ranges for each enemy
		for j in 5-i:
			chanceRanges[i+j]+=chanceArray[i]
	
	spawnWave()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(enemiesToSpawn>0):
		enemySpawnTimer+=delta
		if(enemySpawnTimer>enemySpawnTime):
			enemySpawnTimer=0
			enemiesToSpawn-=1
			spawnEnemy()
	if(EnemyManager.getEnemyCount()==0 && enemiesToSpawn == 0):
		spawnWave()

func spawnEnemy():
	var randomAngle:float=rng.randf() * PI * 2
	var spawnPosition:Vector2=Vector2(cos(randomAngle),sin(randomAngle))*(ringSize-15)
	
	var enemyFloat=rng.randf()*sumChances
	
	if(enemyFloat<chanceRanges[0]):
		EnemyManager.spawnClownAK47(spawnPosition)
	elif(enemyFloat<chanceRanges[1]):
		EnemyManager.spawnClown(spawnPosition)
	elif(enemyFloat<chanceRanges[2]):
		EnemyManager.spawnJester(spawnPosition)
	elif(enemyFloat<chanceRanges[3]):
		EnemyManager.spawnLionTamer(spawnPosition)
	elif(enemyFloat<chanceRanges[4]):
		EnemyManager.spawnRingmaster(spawnPosition)
	
func spawnWave():
	enemiesToSpawn+=enemiesPerWave
