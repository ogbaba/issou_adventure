extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const SPEED = 20
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	translate(Vector3(-1,0,0) * SPEED * delta)