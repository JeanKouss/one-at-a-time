extends Node

var current_playing_node = null
var musicMuted := false


func _ready() -> void:
	CursorManager.register_select_cursor($CanvasLayer/MarginContainer/MusicOffButton, "mouse_entered", "mouse_exited")
	CursorManager.register_select_cursor($CanvasLayer/MarginContainer/MusicOnButton, "mouse_entered", "mouse_exited")
	$CanvasLayer/MarginContainer/MusicOffButton.visible = true
	$CanvasLayer/MarginContainer/MusicOnButton.visible = false

func playMenuMusic() -> void:
	if current_playing_node == $MenuMusic:
		return
	if current_playing_node and current_playing_node.playing :
		var sound_fade_tween := create_tween()
		sound_fade_tween.tween_property(current_playing_node, 'volume_db', -20, 1)
		sound_fade_tween.tween_callback(current_playing_node.stop)
		await sound_fade_tween.finished
	$MenuMusic.volume_db = 0
	current_playing_node = $MenuMusic
	if not musicMuted :
		$MenuMusic.play()

func playInGameMusic() -> void:
	if current_playing_node == $InGameMusic:
		return
	if current_playing_node and current_playing_node.playing :
		var sound_fade_tween := create_tween()
		sound_fade_tween.tween_property(current_playing_node, 'volume_db', -20, 1)
		sound_fade_tween.tween_callback(current_playing_node.stop)
		await sound_fade_tween.finished
	$InGameMusic.volume_db = 0
	current_playing_node = $InGameMusic
	if not musicMuted :
		$InGameMusic.play()

func playCreditsMusic() -> void:
	if current_playing_node == $CreditsMusic:
		return
	if current_playing_node and current_playing_node.playing :
		var sound_fade_tween = create_tween()
		sound_fade_tween.tween_property(current_playing_node, 'volume_db', -20, 1)
		sound_fade_tween.tween_callback(current_playing_node.stop)
		await sound_fade_tween.finished
	$CreditsMusic.volume_db = 0
	current_playing_node = $CreditsMusic
	if not musicMuted :
		$CreditsMusic.play()


func _on_music_off_button_pressed() -> void:
	musicMuted = true
	if current_playing_node :
		current_playing_node.stop()
	$CanvasLayer/MarginContainer/MusicOffButton.visible = false
	$CanvasLayer/MarginContainer/MusicOnButton.visible = true

func _on_music_on_button_pressed() -> void:
	musicMuted = false
	if current_playing_node :
		current_playing_node.play()
	$CanvasLayer/MarginContainer/MusicOffButton.visible = true
	$CanvasLayer/MarginContainer/MusicOnButton.visible = false
