extends Node

export (PackedScene) var dummy

func _ready():
	pass

func _process(_delta):
	# set Charge Bar's current value to player's current charge
	$"Charge Bar".value = $"Player/Bullet Control".CurrentCharge
	# set Charge Bar's max value to player's max charge (necessary due to how it changes with each ability)
	$"Charge Bar".max_value = $"Player/Bullet Control".MaxCharge



func _on_KillButton_pressed(): # when the kill test button is pressed...
	$"Player/Bullet Control".chargeCopyBullet()


func _on_MaxButton_pressed(): # when the max charge button is pressed...
	$"Player/Bullet Control".CurrentCharge = $"Player/Bullet Control".MaxCharge
	$"Player/Bullet Control/Copy Ready".play()


func _on_Respawn_Button_pressed():
	var newDummy = dummy.instance() # instance the new enemy
	add_child(newDummy)	# add it to the tree
	newDummy.position = Vector2(500,80)	# set its position to the same as the old one
