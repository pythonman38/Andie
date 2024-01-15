extends StateBase

@export var hitBoxCollisionShape: CollisionShape3D
@export var vfxAnimationPlayer: AnimationPlayer

var damage: int = 30
var lookDir: Vector3
var lookDir2D: Vector2

func state_update(_delta: float):
	if !animationPlayer.is_playing():
		state_machine.switchTo("ChasePlayer")
	if character.currentHealth == 0:
		state_machine.switchTo("Dead")


func enableHitBox():
	hitBoxCollisionShape.disabled = false
	
	
func disableHitBox():
	hitBoxCollisionShape.disabled = true
	

func enter():
	super.enter()
	character.velocity = Vector3.ZERO
	lookDir = character.player.global_position - character.global_position
	lookDir2D = Vector2(lookDir.z, lookDir.x)
	character.visual.rotation.y = lookDir2D.angle()
	
	
func exit():
	super.exit()
	disableHitBox()


func _on_hit_box_body_entered(body: Node3D):
	if body.is_in_group("Player"):
		body.takeDamage(damage)


func playSmashVFX():
	vfxAnimationPlayer.play("PlayParticle")
