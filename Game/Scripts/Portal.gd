extends Node3D

@onready var textLabel: Label = $VisualNode/Sprite3D/SubViewport/Label

var coinRequired: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	textLabel.text = str(coinRequired)


func _on_area_3d_body_entered(body: Node3D):
	if body.is_in_group("Player"):
		if body.coinNumber >= coinRequired:
			print("The Player has reached the portal!")
		else:
			print("The Player doesn't have enough coins!")
