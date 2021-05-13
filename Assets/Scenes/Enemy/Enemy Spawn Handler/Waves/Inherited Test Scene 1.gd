extends "res://Assets/Scenes/Enemy/Enemy Spawn Handler/Waves/Default Wave.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	spawner.spawnEnemy(bombEnemy, 1)
	spawner.spawnEnemy(bombEnemy, 3)
	spawner.spawnEnemy(piercerEnemy, 4)
	spawner.spawnEnemy(bombEnemy, 5)
	spawner.spawnEnemy(bombEnemy, 7)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
