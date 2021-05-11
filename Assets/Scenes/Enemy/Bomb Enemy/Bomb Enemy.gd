extends "res://Assets/Scenes/Enemy/Basic Enemy/Enemy.gd"


# Declare member variables here. Examples:
export (PackedScene) var bullet

# Called when the node enters the scene tree for the first time.

func explode(var numberOfShots): # shoots a bunch of bullets in a circle
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
		owner.add_child(newBullet)
		
		queue_free()


func _on_Explosion_Timer_timeout():
	explode(12)
