extends Node


# Declare member variables here. Examples:
var SelectedSpawnpoint = 1

export (PackedScene) var bombEnemy
export (PackedScene) var piercerEnemy

export (PackedScene) var testWave1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Selector_value_changed(value):
	SelectedSpawnpoint = int(value)
	$Label.text = str(value)


func _on_Spawn_Piercer_pressed():
	$"Enemy Spawn Handler".spawnEnemy(piercerEnemy, SelectedSpawnpoint)


func _on_Spawn_Bomb_pressed():
	$"Enemy Spawn Handler".spawnEnemy(bombEnemy, SelectedSpawnpoint)


func _on_Add_Test_Wave_pressed():
	var newWave = testWave1.instance()
	add_child(newWave)
