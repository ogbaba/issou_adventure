extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const SPEED = 2
var hunt = false
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if hunt:
		_hunt(delta);

func set_hunt(boolean):
	hunt = boolean;

func _hunt(delta):
	var player_pos = get_node("../Player").get_translation()
	look_at(player_pos,Vector3(0,1,0))
	move((player_pos - get_translation()).normalized() * delta * SPEED)