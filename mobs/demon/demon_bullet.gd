extends Area3D
class_name DemonBullet
var speed: float = 20
var fly_direction: Vector3
var velocity: Vector3

func _process(delta: float) -> void:
	velocity = fly_direction * speed * delta
	global_position = velocity + global_position



func _on_life_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	queue_free() # Replace with function body.
