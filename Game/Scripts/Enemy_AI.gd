extends CharacterBody3D

@onready var navAgent: NavigationAgent3D = $NavigationAgent3D
@onready var visual: Node3D = $VisualNode
@onready var animationPlayer: AnimationPlayer = $VisualNode/AnimationPlayer
@onready var materialEffectAnimationPlayer: AnimationPlayer = $VisualNode/MaterialEffectAnimationPlayer

var player: Node3D
var direction: Vector3
var maxHealth: int = 100
var currentHealth: int

const SPEED: float = 0.5

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	currentHealth = maxHealth


func _physics_process(_delta):
	move_and_slide()


func applyDamage(damage: int):
	currentHealth -= damage
	currentHealth = clamp(currentHealth, 0, maxHealth)
	materialEffectAnimationPlayer.play("Flash")
