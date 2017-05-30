extends KinematicBody

const SPEED = 50
const ACCEL = 4
var velocity = Vector3()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	_init_buttons()
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	_walk(delta)

func _walk(delta):
	var aim = get_node("Camera").get_global_transform().basis
	var direction = Vector3()
	if Input.is_action_pressed("forward"):
		direction -= aim[2]
	if Input.is_action_pressed("backward"):
		direction += aim[2]
	if Input.is_action_pressed("left"):
		rotate(Vector3(0,1,0), -PI/128)
	if Input.is_action_pressed("right"):
		rotate(Vector3(0,1,0),PI/128)
	direction = direction.normalized()
	var target = direction*SPEED
	velocity = Vector3().linear_interpolate(target,ACCEL * delta)
	var motion = velocity * delta
	motion = move(motion)
	var original_vel = velocity
	var attempts = 4
	while(attempts and is_colliding()):
		var n=get_collision_normal()
		motion=n.slide(motion)
		velocity=n.slide(velocity)
		if(original_vel.dot(velocity)>0):
			motion=move(motion)
		if (motion.length()<0.001):
			break
			attempts-=1

func _init_buttons():
	var vp_size = get_viewport().get_visible_rect().size
	var ui_scale = vp_size.x / 500
	get_node("btn_forward").set_action("forward")
	get_node("btn_backward").set_action("backward")
	get_node("btn_right").set_action("right")
	get_node("btn_left").set_action("left")
	
	get_node("btn_forward").set_scale(Vector2(ui_scale,ui_scale))
	get_node("btn_backward").set_scale(Vector2(ui_scale,ui_scale))
	get_node("btn_left").set_scale(Vector2(ui_scale,ui_scale))
	get_node("btn_right").set_scale(Vector2(ui_scale ,ui_scale))
	
	get_node("btn_forward").set_pos(Vector2(0, vp_size.y - 64 * ui_scale * 2))
	get_node("btn_backward").set_pos(Vector2(64 * ui_scale ,vp_size.y))
	get_node("btn_right").set_pos(Vector2(vp_size.x,  vp_size.y - 64 * ui_scale))
	get_node("btn_left").set_pos(Vector2(vp_size.x - 64 * ui_scale * 2,  vp_size.y))

# check that the resulting velocity is not opposite to
# the original velocity, which would mean moving backward.