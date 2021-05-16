extends "res://Assets/Scenes/Enemy/Basic Enemy/Enemy.gd"


# Declare member variables here. Examples:
export (PackedScene) var bullet
export (AudioStream) var explosionSound
export var numberOfBullets = 12

# Called when the node enters the scene tree for the first time.

func explode(var numberOfShots): # shoots a bunch of bullets in a circle
	# hehe explodey noise
	# if this AudioStreamPlayer is a child of this enemy, then when the enemy
	# destroys itself at the end of this function, it will be destroyed as well
	# to get around that, we instead add the AudioStreamPlayer as a child of
	# this enemy's parent, which should just be the game scene
	var explosionPlayer = AudioStreamPlayer.new() 
	explosionPlayer.set_stream(explosionSound)
	get_parent().add_child(explosionPlayer)
	explosionPlayer.play()
	
	for n in numberOfShots: # Do the following code for each bullet spawned
		var newBullet = bullet.instance() # instantiate a new bullet
		newBullet.position = position
		# this angle will be used to rotate a number of things. it'll make a pretty circle
		var rotationAngle = PI * 2 / numberOfShots * n
		# rotate the bullet's travel direction
		newBullet.direction = newBullet.direction.rotated(rotationAngle)
		# rotate the bullet's sprite
		newBullet.get_node("Sprite").rotation_degrees += rad2deg(rotationAngle)
		# rotate the bullet's hitbox
		newBullet.get_node("Hitbox").rotation_degrees += rad2deg(rotationAngle)
		get_parent().add_child(newBullet)
		
		queue_free()


func _on_Explosion_Timer_timeout():
	explode(numberOfBullets)	# Explode with user specified number of bullets
