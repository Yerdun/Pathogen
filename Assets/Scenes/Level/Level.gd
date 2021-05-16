extends Node2D


# This script is for UI elements and keeping track of score
func _ready():
	# Reset all scores to 0 on game start
	GlobalVariables.finalLoopCount = 0
	GlobalVariables.finalWave = 0
	GlobalVariables.enemiesKilled = 0

func _process(delta):
	if Input.is_action_pressed("ui_pause") and $"Pause Popup/Pause Cooldown".is_stopped():
		get_tree().paused = true	# Pause game when pause button is pressed
		$"Pause Popup".show()	# Show pause popup menu
		$"Pause Popup/Pause Button".grab_focus()	# Focus so controller can unpause
	
	GlobalVariables.finalLoopCount = $"Wave Manager".loopCounter	# Set loop count to current loop
	GlobalVariables.finalWave = 6 - $"Wave Manager".randomizedList.size()	# Set finalWave to the current wave
	# Enemy kill count handled in Bullet Control

	$"Charge Bar".max_value = $"Player/Bullet Control".MaxCharge	# Must check for this repeatedly because MaxCharge increases upon copy
	$"Charge Bar".value = $"Player/Bullet Control".CurrentCharge	# Set the Charge Bar's value to a percentage of the Player's current charge
	$"Copy Bar text".text = "Copy Charge   " + str($"Player/Bullet Control".CurrentCharge) + " / " + str($"Player/Bullet Control".MaxCharge)	# Overlay fraction ready over bar
	$Lives.text = "x " + str($Player.lives)	# Display score aspects to their appropriate labels
	$Loop.text = "Loop " + str(GlobalVariables.finalLoopCount)
	$Wave.text = "Wave " + str(GlobalVariables.finalWave) + " / 6"
	$Kills.text = "Kills " + str(GlobalVariables.enemiesKilled)


func _on_Pause_Button_pressed():
	get_tree().paused = false	# Unpause game when the button in the pause popup is pressed
	$"Pause Popup".hide()	# Hide pause popup
	$"Pause Popup/Pause Cooldown".start(0.5)	# Start the pause timer so player can't spam pause
