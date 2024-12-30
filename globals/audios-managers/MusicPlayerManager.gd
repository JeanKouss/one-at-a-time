extends Node

var current_playing_node = null

func playMenuMusic() -> void:
	if current_playing_node == $MenuMusic:
		return
	if current_playing_node :
		var sound_fade_tween := create_tween()
		sound_fade_tween.tween_property(current_playing_node, 'volume_db', -20, 1)
		sound_fade_tween.tween_callback(current_playing_node.stop)
		await sound_fade_tween.finished
	$MenuMusic.volume_db = 0
	$MenuMusic.play()
	current_playing_node = $MenuMusic

func playInGameMusic() -> void:
	if current_playing_node == $InGameMusic:
		return
	if current_playing_node :
		var sound_fade_tween := create_tween()
		sound_fade_tween.tween_property(current_playing_node, 'volume_db', -20, 1)
		sound_fade_tween.tween_callback(current_playing_node.stop)
		await sound_fade_tween.finished
	$InGameMusic.volume_db = 0
	$InGameMusic.play()
	current_playing_node = $InGameMusic

func playCreditsMusic() -> void:
	if current_playing_node == $CreditsMusic:
		return
	if current_playing_node :
		var sound_fade_tween = create_tween()
		sound_fade_tween.tween_property(current_playing_node, 'volume_db', -20, 1)
		sound_fade_tween.tween_callback(current_playing_node.stop)
		await sound_fade_tween.finished
	$CreditsMusic.volume_db = 0
	$CreditsMusic.play()
	current_playing_node = $CreditsMusic