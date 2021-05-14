extends "res://Assets/Scenes/Enemy/Basic Enemy/Enemy.gd"

export (PackedScene) var bullet
#export (AudioStream) var shotSound

export var bulletsToShoot = 10
var isShooting


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Hitbox".shape.extents = Vector2(32,24)	# Hitbox better fits sprite
	isShooting = false	# Enemy starts off not shooting

func _physics_process(delta):
	# Enemy starts out moving, opposite force slows it to a halt
	if linear_velocity.x >= 0:	# When the force pushes it enough to move right
		applied_force = Vector2.ZERO	# Stop the enemy (no force, no velocity)
		linear_velocity.x = 0
		if !isShooting:	# If the enemy is currently not shooting
			_shoot(bulletsToShoot)	# Shoot at the player


func _shoot(numBullets):
	isShooting = true	# Set isShooting to true, so the enemy doesn't infinitely shoot
	
	for i in numBullets: # Repeat this for each bullet
		var newBullet = bullet.instance() # Instantiate bullet
		newBullet.position = position - Vector2(28, 0)	# Bullets spawn from the yellow part of the sprite
		var playerPosition = $"../Player".get_position()	# Get Player's position (this is a vector)
		
		newBullet.direction = position.direction_to(playerPosition)	# Set bullet's direction to the angle towards player
		newBullet.get_node("Sprite").rotation = position.angle_to_point(playerPosition)	# Rotate bullet to face player
		newBullet.get_node("Hitbox").rotation = position.angle_to_point(playerPosition)	# Rotate bullet's hitbox accordingly
		
		get_parent().add_child(newBullet)	# Spawn the bullet
		$"Shooting Sound".play()	# Play the bullet shot sound
		yield(get_tree().create_timer(0.16), "timeout")	# Wait 0.16 seconds between each shot
	
	yield(get_tree().create_timer(0.75), "timeout")	# Wait 3/4 of a second after firing
	var chargePosition = $"../Player".get_position()	# Need to get player position again, since this is out of the loop
	mode = RigidBody2D.MODE_KINEMATIC
	#linear_velocity = position.direction_to(chargePosition)
	#linear_velocity.x = -660	# STUB: Intended to approach player at speed of -660, with a force 880 in the opposite direction to stop it 
	applied_force = Vector2(880, 0)
	isShooting = false	# Set isShooting to false, so it can shoot again
