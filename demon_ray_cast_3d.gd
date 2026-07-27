extends RayCast3D
class_name DemonRayCast
var in_range: bool = false


func _process(delta: float) -> void:
	target_position = to_local(Global.player.global_position)
	if get_collider() is Player:
		in_range = true
	else:
		in_range = false
	print(get_collider())
