extends Node
class_name LevController

var levels_dir_path := 'res://scenes/levels/'
var levels := {}

func _ready() -> void:
	scan_levels()
	print(levels)


func send_next_level(following:int=-1) :
	var lv_path = levels.get(following+1)
	if not lv_path :
		push_error('No level following index ', following)
		return
	SceneManager.change_scene(lv_path)


func scan_levels() :
	var i = 0
	while true :
		var lv_name = levels_dir_path + "level{0}/Level{0}.tscn".format([i])
		if FileAccess.file_exists(lv_name) :
			levels[i] = lv_name
			i += 1
		else :
			break