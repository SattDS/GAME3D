extends CharacterBody3D
class_name EnemyDemon
@export var damagable_component_head: DamagableComponent
@export var damagable_component_body: DamagableComponent

func _ready() -> void:
	damagable_component_head.connect("damage_taken",transfer)
	damagable_component_body.connect("died",death)

func _physics_process(delta: float) -> void:
	move_and_slide()
	look_at(Global.player.global_position)
	rotation.y = rotation.y + PI
	rotation.z = 0
	rotation.x = 0
	if !is_on_floor():
		velocity += Global.G * delta
		
func death():
	queue_free()

func transfer(damage):
	damagable_component_body.take_damage(damage * 2)
