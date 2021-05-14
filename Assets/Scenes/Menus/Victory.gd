extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var loopCount

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Score".text = "Loops cleared: " + str(GlobalVariables.finalLoopCount)	+ "\nWaves in loop survived: " + str(GlobalVariables.final)# Print the amount of loops the player has gone through


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$"Menu Click".play()
	$Sprite.queue_free()
	$ColorRect.queue_free()
	$Button.queue_free()
	$"Loop amount".queue_free()
	$"Loops description".queue_free()

