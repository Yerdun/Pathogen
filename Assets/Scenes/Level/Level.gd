extends Node2D

# This script is for UI elements and keeping track of score
func _ready():
	# Reset all scores to 0 on game start
	GlobalVariables.finalLoopCount = 0
	GlobalVariables.finalWave = 0
	GlobalVariables.enemiesKilled = 0

func _process(delta):
	GlobalVariables.finalLoopCount = $"Wave Manager".loopCounter	# Set loop count to current loop
	GlobalVariables.finalWave = 6 - $"Wave Manager".randomizedList.size()	# Set finalWave to the current wave
	# Enemy kill count handled in Bullet Control
	
	$"Charge Bar".max_value = $"Player/Bullet Control".MaxCharge	# Must check for this repeatedly because MaxCharge increases upon copy
	$"Charge Bar".value = $"Player/Bullet Control".CurrentCharge	# Set the Charge Bar's value to a percentage of the Player's current charge
	if $"Player/Bullet Control".CurrentCharge == $"Player/Bullet Control".MaxCharge:
		$"Copy Bar text".text = "Copy ready!"	# Display message when copy is ready
	else:
		$"Copy Bar text".text = "Copy Ability Charging..."
	$"Lives".text = "x " + str($"Player".lives)
	$"Score".text = "Wave: " + str(GlobalVariables.finalWave) + " / 6\nLoop: " + str(GlobalVariables.finalLoopCount + 1) + "\nKills: " + str(GlobalVariables.enemiesKilled)
