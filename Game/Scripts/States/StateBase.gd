class_name StateBase
extends Node

var state_machine: StateMachine
var character: CharacterBody3D
var animationPlayer: AnimationPlayer

@export var animationName: String = ''

func enter():
	animationPlayer.play(animationName)
	

func exit():
	pass
	
	
func state_update(_delta: float):
	pass
