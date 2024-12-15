extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	(get_parent() as Level).toy_exited_map.connect(update_score_ui)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_score_ui(n_exited:int, min2exit:int) :
	%ScoreLabel.text = str(n_exited)+'/'+str(min2exit)

func _on_previous_level_pressed() -> void:
	(get_parent() as Level).request_prev_level()
	pass # Replace with function body.

func _on_next_level_pressed() -> void:
	(get_parent() as Level).request_next_level()

func _on_restart_level_pressed() -> void:
	(get_parent() as Level).request_level_reload()
