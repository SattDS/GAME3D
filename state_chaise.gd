extends State
@export var demon: EnemyDemon
@export var agent: NavigationAgent3D
@export var raycast: DemonRayCast
@export var animation_player: AnimationPlayer
@export var demon_speed = 5


func Enter():
	animation_player.play("Walk")
	agent.set_target_position(Global.player.global_position)
	
	
func Physics_Update(delta: float):
	agent.set_target_position(Global.player.global_position)
	var next_position = agent.get_next_path_position()
	demon.look_at(next_position)
	demon.rotation.y = demon.rotation.y + PI
	demon.rotation.z = 0
	demon.rotation.x = 0
	demon.velocity = (next_position - demon.global_position).normalized() * demon_speed
	demon.move_and_slide()
	
func Update(delta: float):
	if raycast.in_range:
		demon.velocity = Vector3.ZERO
		Transitioned.emit(self,"state_attack")
	
