extends CanvasLayer

var lev_button_scene := preload("res://scenes/screens/level-list/LevelButton.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicPlayerManager.playMenuMusic()
	init_lev_buttons()
	CursorManager.register_select_cursor($BackButton, "mouse_entered", "mouse_exited")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_lev_but_pressed(lev_num:int) :
	AudioPlayerManager.click()
	LevelsController.reload_level(lev_num)

func init_lev_buttons() :
	for lev in LevelsController.levels :
		var button : Button = lev_button_scene.instantiate()
		button.text = 'Level ' + str(lev)
		button.pressed.connect(_on_lev_but_pressed.bind(lev))
		%LevelButtonsContainer.add_child(button)
		CursorManager.register_select_cursor(button, "mouse_entered", "mouse_exited")

func _on_back_button_pressed() -> void:
	AudioPlayerManager.click()
	SceneManager.change_scene("res://scenes/screens/home/Home.tscn")
