extends Node

export (PackedScene) var BasicBullet # reference to basic bullet
export (PackedScene) var PiercingBullet # reference to piercing bullet

var SelectedBullet # the currently active bullet

var canFire # true if shot is not on cooldown

var rapidFireEnabled # true if rapid fire enabled

var wideBeamEnabled # true if shot is wide
var wideSpacing = 30 #avoiding magic numbers; space between wide beam bullets

var piercingEnabled # true if piercing is enabled


func _ready():
	SelectedBullet = BasicBullet # defaults selected bullet as basic bullet
	canFire = true # ready shot cooldown immediately
	rapidFireEnabled = false
	wideBeamEnabled = false
	piercingEnabled = false

func _process(delta):
	pass


func _on_Shoot_Button_pressed():
	if canFire: #in the future, this would be linked to the controls instead
		# instance selected bullet and spawn it in
		var NewBullet = SelectedBullet.instance()
		add_child(NewBullet)
		# place it at the firing point
		NewBullet.position = $SpawnPos.position
		# the bullet is coded to move on its own, so no further action needed
		
		#if the wide beam is enabled, instance two more bullets and space them
		if wideBeamEnabled:
			var WideBullet1 = SelectedBullet.instance()
			var WideBullet2 = SelectedBullet.instance()
			add_child(WideBullet1)
			add_child(WideBullet2)
			WideBullet1.position = $SpawnPos.position + wideSpacing * Vector2.UP
			WideBullet2.position = $SpawnPos.position + wideSpacing * Vector2.DOWN
		# put shot on cooldown and start the cooldown timer
		canFire = false
		$"Shot Cooldown".start()


func _on_Shot_Cooldown_timeout():
	canFire = true # when the cooldown timer runs out, ready next shot


func _on_Fast_Button_pressed():
	rapidFireEnabled = !rapidFireEnabled #toggle rapidfire mode
	#if rapid fire is on, lower the cooldown timer. otherwise, turn it back up
	if rapidFireEnabled:
		$"Shot Cooldown".wait_time = .25
	else:
		$"Shot Cooldown".wait_time = .5


func _on_Wide_Button_pressed():
	wideBeamEnabled = !wideBeamEnabled


func _on_Piercing_Button_pressed():
	piercingEnabled = !piercingEnabled
	if piercingEnabled:
		SelectedBullet = PiercingBullet
	else:
		SelectedBullet = BasicBullet
