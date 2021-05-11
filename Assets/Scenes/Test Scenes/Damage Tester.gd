extends Node

func _ready():
	# set Charge Bar's max value to player's max charge
	$"Copy Charge".max_value = $"Player/Bullet Control".MaxCharge
	$Lives.text = "Lives: " + str($Player.lives) + "x"

func _process(_delta):
	# set Charge Bar's current value to player's current charge
	$"Copy Charge".value = $"Player/Bullet Control".CurrentCharge
	$Lives.text = "Lives: " + str($Player.lives) + "x"

