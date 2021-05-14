extends Node

func _ready():
	pass

func _process(_delta):
	# set Charge Bar's current value to player's current charge
	$"Charge Bar".value = $"Player/Bullet Control".CurrentCharge
	# set Charge Bar's max value to player's max charge (necessary due to how it changes with each ability)
	$"Charge Bar".max_value = $"Player/Bullet Control".MaxCharge



func _on_KillButton_pressed(): # when the kill test button is pressed...
	$"Player/Bullet Control".chargeCopyBullet()
