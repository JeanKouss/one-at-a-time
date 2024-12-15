extends CanvasLayer


var level_node : Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent() is Level :
		level_node = get_parent()
		if not level_node.is_node_ready() :
			await level_node.ready
		level_node.toy_exited_map.connect(update_score_ui)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_score_ui(n_exited:int, min2exit:int) :
	%ScoreLabel.text = str(n_exited)+'/'+str(min2exit)

func _on_previous_level_pressed() -> void:
	if not level_node :
		return
	level_node.request_prev_level()

func _on_next_level_pressed() -> void:
	if not level_node :
		return
	level_node.request_next_level()

func _on_restart_level_pressed() -> void:
	if not level_node :
		return
	level_node.request_level_reload()
