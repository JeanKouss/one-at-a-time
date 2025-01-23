extends CanvasLayer


var level_node : Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LevelClearPanel.visible = false
	$LevelFailedPanel.visible = false
	if get_parent() is Level :
		level_node = get_parent()
		if not level_node.is_node_ready() :
			await level_node.ready
		level_node.toy_exited_map.connect(update_score_ui)
		update_score_ui(0, level_node.min_toy_to_exit)
		%LevelName.text = "Level "+str(level_node.get_lev_id())
		level_node.level_passed.connect(_on_level_clear)
		level_node.level_failed.connect(_on_level_failed)
	for child in $LevelBox/VBoxContainer/Navigations.get_children() :
		CursorManager.register_select_cursor(child, "mouse_entered", "mouse_exited")
	for child in $LevelFailedPanel/HBoxContainer.get_children() :
		CursorManager.register_select_cursor(child, "mouse_entered", "mouse_exited")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_score_ui(n_exited:int, min2exit:int) :
	%ScoreLabel.text = str(n_exited)+'/'+str(min2exit)

func _on_previous_level_pressed() -> void:
	AudioPlayerManager.click()
	if not level_node :
		return
	level_node.request_prev_level()

func _on_next_level_pressed() -> void:
	AudioPlayerManager.click()
	if not level_node :
		return
	level_node.request_next_level()

func _on_restart_level_pressed() -> void:
	AudioPlayerManager.click()
	if not level_node :
		return
	level_node.request_level_reload()


func _on_levels_list_pressed() -> void:
	AudioPlayerManager.click()
	level_node.request_levels_list()

func _on_level_clear(_n_exited:int, _min_to_exit:int) :
	$AnimationPlayer.play('lev_clear')

func _on_level_failed() :
	$AnimationPlayer.play("lev_failed")

func _on_lev_clear_animation_finished() -> void:
	if not level_node :
		return
	level_node.request_next_level()