extends Control

@onready var coinLabel: Label = $HBoxContainer_Coin/Label_Coin

@export var player: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	player.coinNumberUpdated.connect(updateCoinLabel)


func updateCoinLabel(newValue: int):
	coinLabel.text = str(newValue)
