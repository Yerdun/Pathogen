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
var wideSpacing = 30 # avoiding magic numbers; space between wide beam bullets

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
	_shoot() 

func _shoot(): # handles shooting controls and cooldown
	# if player is trying to use copy ability, cd is ready, and charge is max 
	if Input.is_action_pressed("copy") and canFire and CurrentCharge == MaxCharge:
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
		# instance selected bullet and spawn it in
		var NewBullet = SelectedBullet.instance()
		# normal bullets emit a signal when they kill an enemy, next line links it to function
		NewBullet.connect("killed_enemy", self, "chargeCopyBullet")
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



func _enableRapidFire(): # when called, enables rapid fire
	if !rapidFireEnabled:
		$"Shot Cooldown".wait_time = .25
	rapidFireEnabled = true

func _enableWideBeam(): # when called, enables wide beam
	wideBeamEnabled = true

func _enablePiercing(): # when called, enables piercing
	if !piercingEnabled:
		SelectedBullet = PiercingBullet
	piercingEnabled = true

func _on_Shot_Cooldown_timeout(): # connected to cooldown timer
	canFire = true # when the cooldown finishes, prepare a new shot

func chargeCopyBullet(): # call this function when an enemy dies
	# if current charge is max, do nothing, but if current charge is below max, increment by 1
	CurrentCharge = min(MaxCharge, CurrentCharge + 1)
