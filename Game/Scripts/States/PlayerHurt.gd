extends StateBase

@export var materialEffectAnimationPlayer: AnimationPlayer

var pushBackDir: Vector3
var pushBackSpeed: float = 50.0

func enter():
	super.enter()
	character.velocity = Vector3.ZERO
	materialEffectAnimationPlayer.play("Hurt_Flash")
	if character.currentHealth == 0:
		state_machine.switchTo("Dead")


func state_update(_delta: float):
	character.velocity = pushBackDir * pushBackSpeed * _delta
	if !animationPlayer.is_playing():
		state_machine.switchTo("Idle")


func exit():
	super.exit()
	character.velocity = Vector3.ZERO
