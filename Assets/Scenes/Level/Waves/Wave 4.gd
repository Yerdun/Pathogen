extends "res://Assets/Scenes/Enemy/Enemy Spawn Handler/Waves/Default Wave.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	spawner.spawnEnemy(shooterEnemy, 1)
	spawner.spawnEnemy(shooterEnemy, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getWaveLength():
	return 33


func _on_Timer_timeout():
	spawner.spawnEnemy(shooterEnemy, 6)
	spawner.spawnEnemy(shooterEnemy, 7)
	$Timer2.start()


func _on_Timer2_timeout():
	spawner.spawnEnemy(shooterEnemy, 3)
	spawner.spawnEnemy(shooterEnemy, 4)
	spawner.spawnEnemy(shooterEnemy, 5)
	$Timer3.start()


func _on_Timer3_timeout():
	spawner.spawnEnemy(shooterEnemy, 3)
	spawner.spawnEnemy(bombEnemy, 4)
	spawner.spawnEnemy(shooterEnemy, 5)
	$Timer4.start()


func _on_Timer4_timeout():
	spawner.spawnEnemy(piercerEnemy, 4)
	$Timer5.start()


func _on_Timer5_timeout():
	spawner.spawnEnemy(piercerEnemy, 2)	
	spawner.spawnEnemy(piercerEnemy, 6)
	$Timer6.start()


func _on_Timer6_timeout():
	spawner.spawnEnemy(bombEnemy, 4)
	$Timer7.start()
