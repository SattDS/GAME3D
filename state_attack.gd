extends State
@export var demon: EnemyDemon
@export var gun_barrel_marker: Marker3D
@export var timer_attack: Timer
@export var bullet_path: String
var player: Player

func Enter():
	player = Global.player
	
func Update(delta: float):
	var bullet: DemonBullet = Global.create_scene(bullet_path)
	bullet.global_position = gun_barrel_marker.global_position
