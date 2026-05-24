extends Node3D
class_name Revolver
@onready var muzzle_flash_05: VFXController = $MuzzleFlash_05
var shot_particles = ("res://hit.tscn")

func _physics_process(delta: float) -> void:
	pass
	
func shot(raycast: RayCast3D):
	$AnimationPlayer.play("shot")

	var shotted_target = raycast.get_collider()
	if shotted_target != null:
		#shotted_target.queue_free()
		raycast.get_collision_point()
		
		var particles: GPUParticles3D = Global.create_scene(shot_particles)
		particles.emitting = true
		particles.look_at(raycast.get_collision_normal())
		
		particles.global_position = raycast.get_collision_point()
