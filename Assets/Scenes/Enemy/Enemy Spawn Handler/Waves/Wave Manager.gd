extends Node

# a list of every single wave
# if there is still any waves in the list:
# add that wave as a child to this node's parent and remove it from the list
# each wave node is programmed to automatically work once added as child
# when the number of waves reaches zero, change the scene to the win screen

export (PackedScene) var wave0
export (PackedScene) var wave1
export (PackedScene) var wave2
export (PackedScene) var wave3
export (PackedScene) var wave4
export (PackedScene) var wave5

var randomizedList
var defaultList

var loopCounter = 0	# counts how many loops you have

func _ready():
	defaultList = range(6) # I assume I'll just make 6 waves
	randomizedList = []
	print(defaultList)
	randomize() # we'll be randomizing the waves
	# the following for loop puts the elements of defaultList into randomizedList
	# in a random order
	for i in range(6):
		var x = randi()%defaultList.size() # gives a random integer of defaultList's size
		randomizedList.push_back(defaultList[x]) # adds the element at that index from defaultList to randomizedList
		defaultList.remove(x) # and then removes that element for future iterations
	print(randomizedList)


func _on_Spawn_Timer_timeout(): # every time the timer runs out, try to spawn a wave
	# Spawn Timer autofires, when it runs out the first time the game starts for real
	# if no more waves exist, then win!
	if randomizedList.size() == 0:
		# Loop: Reroll and start another set of six waves
		loopCounter += loopCounter + 1
		print("Loop #", loopCounter + 1)
		_ready()
	else: # but if waves exist:
		var nextWaveNumber = randomizedList.pop_front()
		var nextWaveScene
		match nextWaveNumber:
			0:
				nextWaveScene = wave0
			1:
				nextWaveScene = wave1
			2:
				nextWaveScene = wave2
			3:
				nextWaveScene = wave3
			4:
				nextWaveScene = wave1
			5:
				nextWaveScene = wave2
			_:
				print("Something went wrong.")
				nextWaveScene = wave0
				
		# instance the wave
		var nextWaveInstance = nextWaveScene.instance()
		
		
		
		# set the next wave to spawn when this wave ends
		get_parent().add_child(nextWaveInstance)
		$"Spawn Timer".wait_time = nextWaveInstance.getWaveLength()
		$"Spawn Timer".start()
