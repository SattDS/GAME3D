extends CharacterBody3D
var speed  : float = 5



func _physics_process(delta: float) -> void:
	velocity = Vector3.ONE
	#look_at(Global.player.global_position)
	velocity = global_position.direction_to(Global.player.global_position) 
	velocity = velocity * speed
	if !is_on_floor():
		velocity += Global.G * delta
	move_and_slide()
