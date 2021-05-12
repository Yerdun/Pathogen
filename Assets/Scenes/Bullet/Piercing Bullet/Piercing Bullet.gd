extends Area2D

export var speed = 900 # the speed at which the bullet will travel
export var damage = 1 # the amount of damage the bullet does to enemies on hit

signal killed_enemy

func _ready():
	pass

func _physics_process(delta):
	position += Vector2.RIGHT * speed * delta # go right


func _killed_enemy():
	emit_signal("killed_enemy")


func _on_Piercing_Bullet_body_entered(body):
	if body.has_method("takeDamage"): # if the hit body can take damage
		body.takeDamage(damage) # do damage to it equal to this bullet's damage value
		if body.currentHP <= 0: # if you killed the enemy,
			_killed_enemy() # neat! tell everyone, including the player
	
	# the bullet pierces, so it doesn't destroy itself
