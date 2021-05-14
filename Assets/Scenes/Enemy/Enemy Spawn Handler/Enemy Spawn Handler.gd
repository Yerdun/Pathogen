extends Node2D


# Declare member variables here. Examples:

# references to the enemy scenes
export (PackedScene) var bombEnemy
export (PackedScene) var piercerEnemy
export (PackedScene) var chaserEnemy
export (PackedScene) var shooterEnemy


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# when the following function is called, an enemy spawns at the given spawnpoint
# enemy type is a PackedScene of the enemy to be spawned, spawnpoint is
# a number between 1 and 7
func spawnEnemy(var enemyType, var spawnpoint, var item):
	var newEnemy = enemyType.instance() # instance the new enemy
	newEnemy.itemToDrop = item
	var spawnlocation = Vector2.ZERO # a vector2 which is the position of where the enemy will spawn
	match spawnpoint:
		1:
			spawnlocation = $"Spawnpoint 1".position
		2:
			spawnlocation = $"Spawnpoint 2".position
		3:
			spawnlocation = $"Spawnpoint 3".position
		4:
			spawnlocation = $"Spawnpoint 4".position
		5:
			spawnlocation = $"Spawnpoint 5".position
		6:
			spawnlocation = $"Spawnpoint 6".position
		7:
			spawnlocation = $"Spawnpoint 7".position
		_:
			print("Something went wrong")
	
	owner.add_child(newEnemy)
	newEnemy.position = position + spawnlocation
