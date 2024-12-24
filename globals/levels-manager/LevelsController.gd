extends Node
class_name LevController

var lev_list_scene_path := "res://scenes/screens/level-list/LevelList.tscn"
var levels_dir_path := 'res://scenes/levels/'
var levels := {}

func _ready() -> void:
	scan_levels()
	print(levels)


func send_next_level(following:int=-1, fall_to_lev_list=true) :
	var lv_path = levels.get(following+1)
	if not lv_path :
		if fall_to_lev_list :
			load_level_list()
		else :
			push_error('No level following index ', following)
		return
	SceneManager.change_scene(lv_path)

func send_previous_level(of:int) :
	var lv_path = levels.get(of-1)
	if not lv_path :
		push_error('No level before index ', of)
		return
	SceneManager.change_scene(lv_path)

func reload_level(lv:int) :
	var lv_path = levels.get(lv)
	if not lv_path :
		push_error('No level of index ', lv)
		return
	SceneManager.change_scene(lv_path)

func load_level_list() :
	SceneManager.change_scene(lev_list_scene_path)

func scan_levels() :
	var i = 0
	while true :
		var lv_name = levels_dir_path + "level{0}/Level{0}.tscn".format([i])
		if ResourceLoader.exists(lv_name) :
			levels[i] = lv_name
			i += 1
		else :
			break