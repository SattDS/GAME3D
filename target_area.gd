extends Area3D
class_name TargetArea
var targets:Array=[]


func _on_body_entered(body: Node3D) -> void:
	targets.append(body)
	


func _on_body_exited(body: Node3D) -> void:
	var index = targets.find(body)
	if index == -1:
		return
	targets.remove_at(index)
