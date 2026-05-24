extends CharacterBody3D
class_name Player
@export var camera: Camera3D
@export var sensitivity: float = 0.005
@export var default_speed: float = 100
@export var speed: float = 100
@export var sprint_speed: float = 110
@export var jump_force = 100
@export var raycast: RayCast3D
@export var revolver: Revolver

func _ready() -> void:
	Global.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(event.relative.x * -sensitivity)
		camera.rotate_x(event.relative.y * -sensitivity)
		camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-90),deg_to_rad(90))
func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("sprint"):
		speed = sprint_speed
	else:
		speed = default_speed
	
	var input_direction = Vector3.ZERO
	
	if Input.is_action_pressed("forward"):
		input_direction.z = -1
		
	if Input.is_action_pressed("back"):
		input_direction.z = 1
		
	if Input.is_action_pressed("left"):
		input_direction.x = -1
		
	if Input.is_action_pressed("right"):
		input_direction.x = 1
		
	var direction = (transform.basis * input_direction)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if !is_on_floor():
		velocity += Global.G * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	print(velocity)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("shot"):
		revolver.shot(raycast)
		
