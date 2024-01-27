extends CharacterBody2D

var speed : float = 200
var maxBounceCount : int = 10
var bounceCount : int = 0
var isPlayerBullet : bool 
var direction
var allEntities = ["ClownAK47", "Player"]

func _ready():
	velocity = direction * speed
	var Player = get_child(0) as Node2D
	var AK47 = get_child(1) as Node2D
	var PlayerColl = get_child(2) as CollisionShape2D
	var AK47Coll = get_child(3) as CollisionShape2D
	
	if isPlayerBullet:
		Player.visible = true
		AK47.visible = false
		PlayerColl.disabled = false
		AK47Coll.disabled = true
		
	else:
		Player.visible = false
		AK47.visible = true
		PlayerColl.disabled = true
		AK47Coll.disabled = false
	
func basicbounce(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if isPlayerBullet :
			if collision_info.get_collider().name in allEntities:
				queue_free()
		else:
			if collision_info.get_collider().name == "Player":
				queue_free()
		if not "Bullet" in collision_info.get_collider().name :
			bounceCount += 1
			velocity = velocity.bounce(collision_info.get_normal())
		else:
			global_position += velocity * delta
	if bounceCount == maxBounceCount:
		queue_free()
	

func _physics_process(delta):
	basicbounce(delta)
	


