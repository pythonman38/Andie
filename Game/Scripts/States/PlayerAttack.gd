extends StateBase

@export var hitBoxCollisionShape: CollisionShape3D

func enableHitBox():
	hitBoxCollisionShape.disabled = false


func disableHitBox():
	hitBoxCollisionShape.disabled = true
	
	
func enter():
	super.enter()
	character.velocity.x = 0
	character.velocity.z = 0
	
	
func exit():
	super.exit()
	disableHitBox()
	
	
func state_update(_delta: float):
	if !animationPlayer.is_playing():
		state_machine.switchTo("Idle")
