extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var parigots = []
var car_scene = load("res://lowpolycar01.scn")
func spawn_parigots(node):
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	parigots.resize(50)
	for i in range (50):
		var car = car_scene.instance()
		car.set_translation(Vector3(randf() * 100 - 50, 0, randf() * 100 - 50))
		car.set_rotation(Vector3(0, randf() * 360, 0))
		print("Adding Parigot")
		parigots.append(car)
		node.add_child(car)
	pass
