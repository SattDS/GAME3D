extends Node
var G = Vector3(0,-20,0)
var player : Player
func create_scene(path: String)->Object: 
	
	var scene = load(path) # Создается шаблон сцены
	var instantiated_scene = scene.instantiate() # Создается экземпляр шаблона сцены
	get_tree().get_root().add_child(instantiated_scene) # Добавление сцены в древо
	return instantiated_scene 
