extends CharacterBody3D
class_name Enemy
@export var damagable_component: DamagableComponent
var speed  : float = 5
var enemy_path = ("res://enemy.tscn")
var child: bool = false

func _ready() -> void:
	damagable_component.connect("died",death)

func _physics_process(delta: float) -> void:
	#velocity = Vector3.ONE
	#look_at(Global.player.global_position)
	velocity.z = global_position.direction_to(Global.player.global_position).z 
	velocity.x = global_position.direction_to(Global.player.global_position).x 
	velocity.z = velocity.z * speed
	velocity.x = velocity.x * speed
	if !is_on_floor():
		velocity += Global.G * delta
	move_and_slide()

	
func death():
	queue_free()
	if child:
		return
	for i in range(2):
		var new_enemy:Enemy = Global.create_scene(enemy_path)
		new_enemy.damagable_component.current_health = new_enemy.damagable_component.max_health * 0.5
		new_enemy.scale = new_enemy.scale * 0.5
		new_enemy.global_position = self.global_position
		new_enemy.global_position.x = global_position.x + randi_range(0,10)
		new_enemy.child = true
