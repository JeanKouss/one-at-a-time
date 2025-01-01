extends Node


func _ready() -> void:
	test_levels()

func test_levels() :
	for lev_path in LevelsController.levels.values() :
		var lev = load(lev_path)
		var level : Level = lev.instantiate()
		if not level.is_valid() :
			print_rich('[color=red]Level ', lev_path, ' is not valid [/color]')
		else :
			print_rich('[color=green]Level ', lev_path, ' is valid [/color]')
		level.queue_free()