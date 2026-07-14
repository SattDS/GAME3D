extends Area3D
class_name DemonBullet
@export var damage: float
var speed: float = 20
var fly_direction: Vector3
var velocity: Vector3


func _process(delta: float) -> void:
	velocity = fly_direction * speed * delta
	global_position = velocity + global_position



func _on_life_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	var scene: VFXControllerBB = Global.create_scene("res://assets/BinbunVFX_Vol2/BattleFX/effects/charge/vfx_blank_charge.tscn")
	scene.global_position = global_position
	scene.one_shot = true
	scene.connect("finished",func():scene.queue_free())
	scene.play()
	queue_free() # Replace with function body.


func _on_area_entered(area: Area3D) -> void:
	if area is DamagableComponent:
		area.take_damage(damage)
