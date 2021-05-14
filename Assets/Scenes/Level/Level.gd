extends Node2D

# this script is probably only for UI elements


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"Charge Bar".max_value = $"Player/Bullet Control".MaxCharge	# Must check for this repeatedly because MaxCharge increases upon copy
	$"Charge Bar".value = $"Player/Bullet Control".CurrentCharge	# Set the Charge Bar's value to a percentage of the Player's current charge
	if $"Player/Bullet Control".CurrentCharge == $"Player/Bullet Control".MaxCharge:
		$"Copy Bar text".text = "Copy ready!"
	else:
		$"Copy Bar text".text = "Copy Ability Charging..."
	$"Lives".text = "x " + str($"Player".lives)
	$"Wave Number".text = "Wave: " + str(6 - $"Wave Manager".randomizedList.size()) + " / 6\nLoop: " + str($"Wave Manager".loopCounter + 1)
