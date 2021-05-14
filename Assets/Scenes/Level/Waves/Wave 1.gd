extends "res://Assets/Scenes/Enemy/Enemy Spawn Handler/Waves/Default Wave.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	spawner.spawnEnemy(piercerEnemy, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getWaveLength():
	return 14


func _on_Timer_timeout():
	spawner.spawnEnemy(piercerEnemy, 6)
	$Timer2.start()


func _on_Timer2_timeout():
	spawner.spawnEnemy(piercerEnemy, 3)
	$Timer3.start()


func _on_Timer3_timeout():
	spawner.spawnEnemy(piercerEnemy, 7)
	$Timer4.start()


func _on_Timer4_timeout():
	spawner.spawnEnemy(piercerEnemy, 4)
	$Timer5.start()


func _on_Timer5_timeout():
	spawner.spawnEnemy(piercerEnemy, 5)
	$Timer6.start()


func _on_Timer6_timeout():
	spawner.spawnEnemy(piercerEnemy, 2)
	$Timer7.start()


func _on_Timer7_timeout():
	spawner.spawnEnemy(bombEnemy, 4)
	$Timer8.start()


func _on_Timer8_timeout():
	spawner.spawnEnemy(bombEnemy, 3)
	spawner.spawnEnemy(bombEnemy, 5)
