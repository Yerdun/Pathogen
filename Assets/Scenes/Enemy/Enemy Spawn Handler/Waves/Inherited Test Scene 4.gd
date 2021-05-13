extends "res://Assets/Scenes/Enemy/Enemy Spawn Handler/Waves/Default Wave.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	spawner.spawnEnemy(piercerEnemy, 4)


func _on_Stagger_Timer_timeout():
	spawner.spawnEnemy(piercerEnemy, 1)
	spawner.spawnEnemy(piercerEnemy, 7)
