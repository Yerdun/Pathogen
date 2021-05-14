extends Node


# reference to the enemy spawn handler
var spawner

# references to the types of enemies
export (PackedScene) var bombEnemy
export (PackedScene) var piercerEnemy
export (PackedScene) var shooterEnemy
export (PackedScene) var chaserEnemy

# how long this wave will last
func getWaveLength():
	return 8


# Called when the node enters the scene tree for the first time.
func _ready():
	spawner = get_parent().get_node("Enemy Spawn Handler")
