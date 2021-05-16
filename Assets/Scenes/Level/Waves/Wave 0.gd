extends "res://Assets/Scenes/Enemy/Enemy Spawn Handler/Waves/Default Wave.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	spawner.spawnEnemy(piercerEnemy, 2, "none")


func _on_Goodbye_timeout():
	spawner.spawnEnemy(bombEnemy, 1, "none")
	spawner.spawnEnemy(bombEnemy, 2, "none")
	spawner.spawnEnemy(bombEnemy, 3, "none")
	spawner.spawnEnemy(bombEnemy, 4, "none")
	spawner.spawnEnemy(bombEnemy, 5, "none")
	spawner.spawnEnemy(bombEnemy, 6, "none")
	spawner.spawnEnemy(bombEnemy, 7, "life")
	queue_free()	# Unload scene after timeout to prevent memory leaks. This is also a part of all other wave scenes.

func getWaveLength():
	return 8
