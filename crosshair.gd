extends Control
class_name UI
@export var curent_collor: Color
@export var target_collor: Color
@export var raycast: RayCast3D


func _process(delta: float) -> void:
	if raycast.get_collider() != null:
		for i: ColorRect in get_tree().get_nodes_in_group("crosshaire"):
			i.color = target_collor
	else:
		for j:ColorRect in get_tree().get_nodes_in_group("crosshaire"):
			j.color = curent_collor

func take_hit():
	$ColorRect.material.set_shader_parameter("alpha",1)
