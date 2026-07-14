extends State
@export var demon: EnemyDemon
@export var gun_barrel_marker: Marker3D
@export var timer_attack: Timer
@export var bullet_path: String
@export var animation_player: AnimationPlayer
var player: Player

func Enter():
	#timer_attack.start()
	animation_player.play("Shoot")
	player = Global.player

func _ready() -> void:
	timer_attack.connect("timeout",shot)

func Update(delta: float):
	pass
	
func shot():
	
	var bullet: DemonBullet = Global.create_scene(bullet_path)
	bullet.global_position = gun_barrel_marker.global_position
	bullet.fly_direction = bullet.global_position.direction_to(player.global_position)
	
func Exit():
	timer_attack.stop()
	
