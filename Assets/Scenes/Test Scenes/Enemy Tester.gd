extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bombExploded


# Called when the node enters the scene tree for the first time.
func _ready():
	bombExploded = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	if !bombExploded:
		$"Bomb Enemy".explode(12)
		bombExploded = true
