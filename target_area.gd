extends Area3D
class_name TargetArea
var targets_bodys:Array=[]
var targets_areas:Array=[]


func _on_body_entered(body: Node3D) -> void:
	targets_bodys.append(body)
	

func _on_body_exited(body: Node3D) -> void:
	var index = targets_bodys.find(body)
	if index == -1:
		return
	targets_bodys.remove_at(index)


func _on_area_entered(area: Area3D) -> void:
	targets_areas.append(area)

func _on_area_exited(area: Area3D) -> void:
	var index = targets_areas.find(area)
	if index == -1:
		return
	targets_areas.remove_at(index)
