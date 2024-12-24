extends Node2D
class_name Level

signal level_passed(n_exited:int, min_to_exit:int)
signal toy_exited_map(n_exited:int, min2exit:int)

@export var min_toy_to_exit : int = 1

var exited_toys : int = 0
var toys : Array[RobToy] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	register_all_toys()
	pass # Replace with function body.


func register_exit_portal(portal) :
	portal.robtoy_exited.connect(_on_toy_exited)
	pass

func _on_toy_exited(toy:RobToy) :
	if not toy is RobToy :
		return
	exited_toys += 1
	toy_exited_map.emit(exited_toys, min_toy_to_exit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func is_level_passed() :
	if exited_toys < min_toy_to_exit :
		return false
	return true

func get_lev_id() :
	return int(name.replace('Level', ''))

func request_next_level() :
	var cur_lev_id = int(name.replace('Level', ''))
	LevelsController.send_next_level(cur_lev_id)

func request_prev_level() :
	var cur_lev_id = int(name.replace('Level', ''))
	LevelsController.send_previous_level(cur_lev_id)

func request_level_reload() :
	var cur_lev_id = int(name.replace('Level', ''))
	LevelsController.reload_level(cur_lev_id)

func request_levels_list() :
	LevelsController.load_level_list()

func register_all_toys() :
	for node in $Toys.get_children() :
		if node is RobToy :
			toys.append(node)
			node.tree_exiting.connect(_on_toy_exiting.bind(node))


func _on_toy_exiting(toy:RobToy) :
	toys.erase(toy)
	if toys.is_empty() :
		if is_level_passed() :
			level_passed.emit(exited_toys, min_toy_to_exit)
			print('level clear')
		else :
			print('level failed')
