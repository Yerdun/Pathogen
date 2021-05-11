extends Node


# reference to the enemy spawn handler
var spawner

# references to the types of enemies
export (PackedScene) var bombEnemy
export (PackedScene) var piercerEnemy



# Called when the node enters the scene tree for the first time.
func _ready():
	spawner = get_parent().get_node("Enemy Spawn Handler")
	spawner.spawnEnemy(bombEnemy, 1)
	spawner.spawnEnemy(bombEnemy, 2)
	spawner.spawnEnemy(bombEnemy, 3)
	spawner.spawnEnemy(piercerEnemy, 4)
	spawner.spawnEnemy(bombEnemy, 5)
	spawner.spawnEnemy(bombEnemy, 6)
	spawner.spawnEnemy(bombEnemy, 7)
