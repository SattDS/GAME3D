extends Node3D
class_name  Sword
@export var animation_player: AnimationPlayer
@export var weapon_tilt: AnimationPlayer
@export var target_area: TargetArea
func deal_damage():
	
	for i in target_area.targets:
		if i is DamagableComponent:
			i.take_damage(50)
			
func parry():
	animation_player.play("parry")
