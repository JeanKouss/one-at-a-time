extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicPlayerManager.playMenuMusic()
	CursorManager.register_select_cursor($BackButton, "mouse_entered", "mouse_exited")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	AudioPlayerManager.click()
	SceneManager.change_scene("res://scenes/screens/home/Home.tscn")
