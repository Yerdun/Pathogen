extends Position2D

export (PackedScene) var BasicBullet # reference to basic bullet
export (PackedScene) var PiercingBullet # reference to piercing bullet
export (PackedScene) var CopyBullet # reference to the copy bullet

export (int) var MaxCharge = 15 # number of enemies to be killed before copy bullet is ready
var CurrentCharge # current progress to charge copy bullet

var SelectedBullet # the currently active bullet

var canFire # true if shot is not on cooldown

var rapidFireEnabled # true if rapid fire enabled

var wideBeamEnabled # true if shot is wide
var wideSpacing = 16 # avoiding magic numbers; space between wide beam bullets

var piercingEnabled # true if piercing is enabled



# Called when the node enters the scene tree for the first time.
func _ready():
	SelectedBullet = BasicBullet # defaults selected bullet as basic bullet
	canFire = true # ready shot cooldown immediately
	rapidFireEnabled = false # default the bullet as basic as possible
	wideBeamEnabled = false
	piercingEnabled = false
	
	CurrentCharge = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if owner.is_dead == false:	# If player is not dead
		_shoot() 	# Allow player to shoot

func _shoot(): # handles shooting controls and cooldown
	# if player is trying to use copy ability, cd is ready, and charge is max 
	if Input.is_action_pressed("copy") and canFire and CurrentCharge == MaxCharge:
		# play copy attempt sound
		$"Copy Fire".play()
		#instance a copy bullet
		var NewCopyBullet = CopyBullet.instance()
		# the Copy Bullet emits signals based on the enemy it hits
		# the next three lines connect those signals to functions in this script
		NewCopyBullet.connect("copied_rapidfire", self, "_enableRapidFire")
		NewCopyBullet.connect("copied_widebeam", self, "_enableWideBeam")
		NewCopyBullet.connect("copied_piercing", self, "_enablePiercing")
		# put the bullet into the world
		owner.owner.add_child(NewCopyBullet)
		NewCopyBullet.position = owner.position + position
		#put shot on cooldown and start the cooldown timer
		canFire = false
		$"Shot Cooldown".start()
		#empty charge meter
		CurrentCharge = 0
	
	# by putting an elif here, copy ability has priority over normal shot
	# if player is shooting normally and cooldown is ready...
	elif Input.is_action_pressed("shoot") and canFire:
		# depending on if pierce shot is active or not, play normal or piercing effect
		if piercingEnabled:
			$"Pierce Fire".play()
		else:
			$"Normal Fire".play()
		# instance selected bullet and spawn it in
		# instanced twice because we fire 2 bullets at a time
		var NewBullet1 = SelectedBullet.instance()
		var NewBullet2 = SelectedBullet.instance()
		# normal bullets emit a signal when they kill an enemy, next line links them to function
		NewBullet1.connect("killed_enemy", self, "chargeCopyBullet")
		NewBullet2.connect("killed_enemy", self, "chargeCopyBullet")
		owner.owner.add_child(NewBullet1)
		owner.owner.add_child(NewBullet2) 
		# the owner of this node is the player
		# the owner of the player is the world, which is what we want the bullets
		# to be the children of, so that player movement does not move the bullets too
		# place them at the firing points
		NewBullet1.position = owner.position + $"Fire Point 1".position
		NewBullet2.position = owner.position + $"Fire Point 2".position
		# the bullets are coded to move on its own, so no further action needed
		
		#if the wide beam is enabled, instance four more bullets and space them
		if wideBeamEnabled:
			var WideBullet1_1 = SelectedBullet.instance()
			var WideBullet1_2 = SelectedBullet.instance()
			var WideBullet2_1 = SelectedBullet.instance()
			var WideBullet2_2 = SelectedBullet.instance()
			owner.owner.add_child(WideBullet1_1)
			owner.owner.add_child(WideBullet1_2)
			owner.owner.add_child(WideBullet2_1)
			owner.owner.add_child(WideBullet2_2)
			WideBullet1_1.position = owner.position + $"Fire Point 1".position + wideSpacing * Vector2.UP
			WideBullet1_2.position = owner.position + $"Fire Point 1".position + wideSpacing * Vector2.DOWN
			WideBullet2_1.position = owner.position + $"Fire Point 2".position + wideSpacing * Vector2.UP
			WideBullet2_2.position = owner.position + $"Fire Point 2".position + wideSpacing * Vector2.DOWN
		# put shot on cooldown and start the cooldown timer
		canFire = false
		$"Shot Cooldown".start()



func _enableRapidFire(): # when called, enables rapid fire
	if !rapidFireEnabled:
		$"Shot Cooldown".wait_time = .25
		$"Copy Success".play()
	rapidFireEnabled = true

func _enableWideBeam(): # when called, enables wide beam
	if !wideBeamEnabled:
		wideBeamEnabled = true
		$"Copy Success".play()

func _enablePiercing(): # when called, enables piercing
	if !piercingEnabled:
		SelectedBullet = PiercingBullet
		$"Copy Success".play()
	piercingEnabled = true

func _on_Shot_Cooldown_timeout(): # connected to cooldown timer
	canFire = true # when the cooldown finishes, prepare a new shot

func chargeCopyBullet(): # call this function when an enemy dies
	# play enemy damage sound (for some reason, it doesn't play on enemy kill)
	$"Enemy Impact".play()
	# play copy ready sound if the charge bar is filled for the first time
	if CurrentCharge + 1 == MaxCharge:
		$"Copy Ready".play()
	# if current charge is max, do nothing, but if current charge is below max, increment by 1
	CurrentCharge = min(MaxCharge, CurrentCharge + 1)
