extends Node3D
@onready var muzzle_flash_05: VFXController = $MuzzleFlash_05
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shot"):
		$AnimationPlayer.play("shot")
	
	
