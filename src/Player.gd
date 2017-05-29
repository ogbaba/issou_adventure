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
# check that the resulting velocity is not opposite to
# the original velocity, which would mean moving backward.