extends Position2D

export (PackedScene) var BasicBullet # reference to basic bullet
export (PackedScene) var PiercingBullet # reference to piercing bullet
export (PackedScene) var CopyBullet # reference to the copy bullet

var SelectedBullet # the currently active bullet

var canFire # true if shot is not on cooldown

var rapidFireEnabled # true if rapid fire enabled

var wideBeamEnabled # true if shot is wide
var wideSpacing = 30 # avoiding magic numbers; space between wide beam bullets

var piercingEnabled # true if piercing is enabled

# Called when the node enters the scene tree for the first time.
func _ready():
	SelectedBullet = BasicBullet # defaults selected bullet as basic bullet
	canFire = true # ready shot cooldown immediately
	rapidFireEnabled = false # default the bullet as basic as possible
	wideBeamEnabled = false
	piercingEnabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_shoot() 

func _shoot(): # handles shooting controls and cooldown
	# if player is shooting and cooldown is ready... 
	if Input.is_action_pressed("shoot") and canFire:
		# instance selected bullet and spawn it in
		var NewBullet = SelectedBullet.instance()
		owner.owner.add_child(NewBullet) # the owner of this node is the player
		# the owner of the player is the world, which is what we want the bullet
		# to be the child of, so that player movement does not move the bullets too
		# place it at the firing point
		NewBullet.position = owner.position + position
		# the bullet is coded to move on its own, so no further action needed
		
		#if the wide beam is enabled, instance two more bullets and space them
		if wideBeamEnabled:
			var WideBullet1 = SelectedBullet.instance()
			var WideBullet2 = SelectedBullet.instance()
			owner.owner.add_child(WideBullet1)
			owner.owner.add_child(WideBullet2)
			WideBullet1.position = owner.position + position + wideSpacing * Vector2.UP
			WideBullet2.position = owner.position + position + wideSpacing * Vector2.DOWN
		# put shot on cooldown and start the cooldown timer
		canFire = false
		$"Shot Cooldown".start()
		# by putting an elif here, the normal shot has priority over copy shot
	elif Input.is_action_pressed("copy") and canFire:
		#instance a copy bullet
		var NewCopyBullet = CopyBullet.instance()
		NewCopyBullet.connect("copied_rapidfire", self, "_enableRapidFire")
		NewCopyBullet.connect("copied_widebeam", self, "_enableWideBeam")
		NewCopyBullet.connect("copied_piercing", self, "_enablePiercing")
		owner.owner.add_child(NewCopyBullet)
		NewCopyBullet.position = owner.position + position
		
		canFire = false
		$"Shot Cooldown".start()



func _enableRapidFire():
	if !rapidFireEnabled:
		$"Shot Cooldown".wait_time = .25
	rapidFireEnabled = true

func _enableWideBeam():
	wideBeamEnabled = true

func _enablePiercing():
	if !piercingEnabled:
		SelectedBullet = PiercingBullet
	piercingEnabled = true


func _on_Shot_Cooldown_timeout():
	canFire = true
