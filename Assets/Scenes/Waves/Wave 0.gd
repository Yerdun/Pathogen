extends "res://Assets/Scenes/Enemy/Enemy Spawn Handler/Waves/Default Wave.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	spawner.spawnEnemy(piercerEnemy, 2)


func _on_Goodbye_timeout():
	spawner.spawnEnemy(bombEnemy, 1)
	spawner.spawnEnemy(bombEnemy, 2)
	spawner.spawnEnemy(bombEnemy, 3)
	spawner.spawnEnemy(bombEnemy, 4)
	spawner.spawnEnemy(bombEnemy, 5)
	spawner.spawnEnemy(bombEnemy, 6)
	spawner.spawnEnemy(bombEnemy, 7)

func getWaveLength():
	return 8
