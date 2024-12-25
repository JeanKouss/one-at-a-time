extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	test_levels()

func test_levels() :
	for lev_path in LevelsController.levels.values() :
		var lev = load(lev_path)
		var level : Level = lev.instantiate()
		if not level.is_valid() :
			push_error('Level ', lev_path, ' is not valid')
		else :
			print('Level ', lev_path, ' is valid')
		level.queue_free()