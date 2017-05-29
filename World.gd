extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var task_cel = false
var task_1 = false
var time = 0
var lbl = Label.new()
var gilbertscn = load("res://Gilbert.tscn")
var gilbert

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	gilbert = gilbertscn.instance()
	get_node("SamplePlayer").set_default_volume(0.2)
	get_node("SamplePlayer").play("LeSatan")
	lbl.set_text("Va voir ton ami Célestin, il est tout seul")
	lbl.set_pos(Vector2(10,40))
	lbl.set_scale(Vector2(2,2))
	lbl.show()
	add_child(lbl)
	set_process(true)
	pass

func _process(delta):
	if !task_cel :
		do_task_cel()
	elif !task_1:
		do_task_1(delta)

func do_task_cel():
	var pos = get_node("Player").get_translation()
	var poscel = get_node("Celestin").get_translation()
	var dist = pos.distance_to(poscel)
	if dist < 1:
		task_cel = true


func do_task_1(delta):
	lbl.set_text("Célestin : Je me suis fait bolosser par Eudes, tu peux le taper stp ?")
	var pos = get_node("Player").get_translation()
	var poseud = get_node("Eudes").get_translation()
	var dist = pos.distance_to(poseud)
	if dist < 0.5:
		lbl.set_text("Eudes : Wesh t'as cru tu fais quoi ? Appelez les haendeks ! \n ECHAPPE À GILBERT")
		add_child(gilbert)
		gilbert.set_hunt(true)
		task_1 = true