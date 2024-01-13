class_name StateBase
extends Node

var state_machine: StateMachine
var character: CharacterBody3D
var animationPlayer: AnimationPlayer

@export var animationName: String = ''

func enter():
	print("entering state: ", name)
	animationPlayer.play(animationName)
	

func exit():
	print("exiting state: ", name)
	
	
func state_update(_delta):
	pass


func showInfo():
	print(name, "/", character, "/", state_machine)
