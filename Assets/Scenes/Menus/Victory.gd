extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var loopCount

# Called when the node enters the scene tree for the first time.
func _ready():
	# Print the player's score
	$"Score".text = "Loops cleared: " + str(GlobalVariables.finalLoopCount)	+ "\nLasted until Wave: " + str(GlobalVariables.finalWave) + "\nMax abilities: " + str(GlobalVariables.mostPowers) + "\nEnemies killed: " + str(GlobalVariables.enemiesKilled)


func _on_Button_pressed():
	$"Menu Click".play()
	$Sprite.queue_free()
	$ColorRect.queue_free()
	$Button.queue_free()
	$"Loop amount".queue_free()
	$"Loops description".queue_free()

