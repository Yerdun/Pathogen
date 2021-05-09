extends Node

func _ready():
	# set Charge Bar's max value to player's max charge
	$"Charge Bar".max_value = $"Player/Bullet Control".MaxCharge

func _process(_delta):
	# set Charge Bar's current value to player's current charge
	$"Charge Bar".value = $"Player/Bullet Control".CurrentCharge



func _on_KillButton_pressed(): # when the kill test button is pressed...
	$"Player/Bullet Control".chargeCopyBullet()
