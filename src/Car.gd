extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var SPEED = 20
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	translate(Vector3(0,1,0) * delta * SPEED)