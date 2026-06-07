extends CharacterBody3D
class_name Enemy
@export var damagable_component: DamagableComponent
var speed  : float = 5
var enemy_path = ("res://enemy.tscn")
var child: bool = false
@export var slime_model: SlimeModel
var attacking: bool = false
var target: DamagableComponent

func _ready() -> void:
	damagable_component.connect("died",death)

func _physics_process(delta: float) -> void:
	if not attacking:	
		slime_model.run()
	look_at(Global.player.global_position)
	rotation.z = 0
	rotation.x = 0
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

func attack_jump():
	attacking = true
	$Timer.start()
	slime_model.jump()
	velocity = Vector3.ZERO

func _on_timer_timeout() -> void:
	attacking = false
	if target != null:
		attack_jump()

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is DamagableComponent:
		target = area
		attack_jump() 
		
		
func _on_area_3d_area_exited(area: Area3D) -> void:
	if area is DamagableComponent:
		target = null

func deal_damage():
	if target != null:
		target.current_health = target.current_health - 20
		print(target.current_health)
