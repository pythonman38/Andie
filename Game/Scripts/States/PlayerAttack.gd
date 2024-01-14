extends StateBase

@export var hitBoxCollisionShape: CollisionShape3D
@export var bladeMaterialEffectAnimationPlayer: AnimationPlayer
@export var VFX_Blade: Node3D
@export var VFX_Hit: GPUParticles3D
@export var nextAttackState: String

var damage: int = 40
var slideSpeed: float = 500.0
var remainSlideDuration: float
var facindDir: Vector3
var canAttackAgain: bool

func enableHitBox():
	hitBoxCollisionShape.disabled = false
	print("Hit box disable = ", hitBoxCollisionShape.disabled)


func disableHitBox():
	hitBoxCollisionShape.disabled = true
	print("Hit box disable = ", hitBoxCollisionShape.disabled)
	
	
func enter():
	super.enter()
	canAttackAgain = false
	character.velocity.x = 0
	character.velocity.z = 0
	VFX_Blade.visible = true
	bladeMaterialEffectAnimationPlayer.stop()
	bladeMaterialEffectAnimationPlayer.play("PlayBladeVFX")
	remainSlideDuration = animationPlayer.current_animation_length * 0.3
		
	
func exit():
	super.exit()
	disableHitBox()
	VFX_Blade.visible = false
	
	
func state_update(_delta: float):
	remainSlideDuration -= _delta
	facindDir = character.visual.transform.basis.z
	if remainSlideDuration > 0:
		character.velocity.x = facindDir.x * slideSpeed * _delta
		character.velocity.z = facindDir.z * slideSpeed * _delta
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, character.SPEED)
		character.velocity.z = move_toward(character.velocity.z, 0, character.SPEED)
	if !animationPlayer.is_playing():
		state_machine.switchTo("Idle")
	if nextAttackState != '' && canAttackAgain && character.attackKey_pressed:
		state_machine.switchTo(nextAttackState)


func _on_hit_box_body_entered(body):
	if body.is_in_group("Enemy"):
		body.applyDamage(damage)
		var position = body.global_position
		position.y = 1.5
		VFX_Hit.global_position = position
		VFX_Hit.restart()
		remainSlideDuration = 0


func setCanAttackAgain():
	canAttackAgain = true
