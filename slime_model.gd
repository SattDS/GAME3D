extends Node3D
class_name SlimeModel

func jump():
	$AnimationPlayer.play("Inkchar1_Jump")
	
	
func idle():
	$AnimationPlayer.play("Inkchar1_Idle")
	
	
func run():
	$AnimationPlayer.play("Inkchar1_Run")
