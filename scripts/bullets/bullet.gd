extends CharacterBody2D

var speed : float = 200
var maxBounceCount : int = 10
var bounceCount : int = 0
var isPlayerBullet : bool 
var direction
var allEntities = ["ClownAK47", "Player"]

func _ready():
	velocity = direction * speed
	var PlayerSp = get_child(0) as Sprite2D
	var EnemySp = get_child(1) as Sprite2D
	var PlayerColl = get_child(2) as CollisionShape2D
	var EnemyColl = get_child(3) as CollisionShape2D
	PlayerSp.visible = isPlayerBullet
	EnemySp.visible = !isPlayerBullet
	PlayerColl.disabled = !isPlayerBullet
	EnemyColl.disabled = isPlayerBullet
	
func death():	
	queue_free()
	
func bouncemethod(direction):
	velocity = velocity.bounce(direction)
	
func basicbounce(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if isPlayerBullet :
			if "Enemy" in collision_info.get_collider().name or collision_info.get_collider().name in allEntities:
				death()
		else:
			if collision_info.get_collider().name == "Player":
				death()
		if (not "Bullet" in collision_info.get_collider().name) && not "Enemy" in collision_info.get_collider().name :
			bounceCount += 1
			bouncemethod(collision_info.get_normal())
		else:
			global_position += velocity * delta
	if bounceCount == maxBounceCount:
		death()

func _physics_process(delta):
	basicbounce(delta)
	


