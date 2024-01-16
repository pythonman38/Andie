extends Node3D

@onready var visual: Node3D = $VisualNode
@onready var VFXanimationPlayer: AnimationPlayer = $VFX/AnimationPlayer

var healthValue: int = 30

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !visual.visible && !VFXanimationPlayer.is_playing():
		queue_free()


func _on_area_3d_body_entered(body: Node3D):
	if body.is_in_group("Player"):
		body.AddHealth(healthValue)
		visual.visible = false
		VFXanimationPlayer.play("PlayParticle")
