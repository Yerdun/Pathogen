extends Node2D

# this script is probably only for UI elements

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Charge Bar".max_value = $"Player/Bullet Control".MaxCharge


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"Charge Bar".value = $"Player/Bullet Control".CurrentCharge
	if $"Player/Bullet Control".CurrentCharge == $"Player/Bullet Control".MaxCharge:
		$"Copy Bar text".text = "Copy ready!"
	else:
		$"Copy Bar text".text = "Copy Ability Charging..."
	$"Lives".text = "x " + str($"Player".lives)
