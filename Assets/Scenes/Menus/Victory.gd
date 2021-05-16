extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var loopCount

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.grab_focus()	# Focus on button for controller users
	# Print the player's score
	$"Score".text = "Loops cleared: " + str(GlobalVariables.finalLoopCount)	+ "\nLasted until Wave: " + str(GlobalVariables.finalWave) + "\nEnemies killed: " + str(GlobalVariables.enemiesKilled)


func _on_Button_pressed():
	$"Menu Click".play()
	$Sprite.queue_free()
	$ColorRect.queue_free()
	$Button.queue_free()
	$"Score".queue_free()
	$Title/TestLevelButton.grab_focus()

