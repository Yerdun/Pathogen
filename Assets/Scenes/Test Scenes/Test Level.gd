extends Node
var x = 0
var time_left = 6

export (PackedScene) var bombEnemy
export (PackedScene) var piercerEnemy

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func _process(delta: float) -> void:
	time_left = time_left-1
	if time_left < 0:
		#if $Player.lives > 0:
			#$"Enemy Spawn Handler".spawnEnemy(piercerEnemy,3)
		if x == 7:
			x = x-7
		else:
			x = x+1
	if time_left < 0:
		time_left += 4


