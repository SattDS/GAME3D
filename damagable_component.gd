extends Area3D
class_name DamagableComponent
@export var max_health = 100
var current_health

func _ready() -> void:
	current_health = max_health
	
func take_damage(damage):
	current_health = current_health - damage
	damage_taken.emit(damage)
	if current_health <= 0:
		death()
		died.emit()
	
	
func death():
	pass	

signal died

signal damage_taken(damage:float)
