extends CharacterBody3D

@onready var navAgent: NavigationAgent3D = $NavigationAgent3D
@onready var visual: Node3D = $VisualNode
@onready var animationPlayer: AnimationPlayer = $VisualNode/AnimationPlayer
@onready var materialEffectAnimationPlayer: AnimationPlayer = $VisualNode/MaterialEffectAnimationPlayer

var player: Node3D
var direction: Vector3
var stopDistance: float = 2.2
var maxHealth: int = 100
var currentHealth: int

const SPEED: float = 0.5

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	currentHealth = maxHealth


func _physics_process(delta):
	navAgent.target_position = player.global_position
	direction = navAgent.get_next_path_position() - global_position
	direction.normalized()
	if navAgent.distance_to_target() < stopDistance:
		animationPlayer.play("NPC_01_IDLE")
		return
	velocity = velocity.lerp(direction * SPEED, delta)
	animationPlayer.play("NPC_01_WALK")
	if velocity.length() > 0.2:
		var lookDir = Vector2(velocity.z, velocity.x)
		visual.rotation.y = lookDir.angle()
	move_and_slide()


func applyDamage(damage: int):
	currentHealth -= damage
	currentHealth = clamp(currentHealth, 0, maxHealth)
	materialEffectAnimationPlayer.play("Flash")
