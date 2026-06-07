extends Node3D
class_name SlimeModel
@export var animation_player: AnimationPlayer

func jump():
	animation_player.play("Inkchar1_Jump")
	
	
func idle():
	animation_player.play("Inkchar1_Idle")
	
	
func run():
	animation_player.play("Inkchar1_Run")
