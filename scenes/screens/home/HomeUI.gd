extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CursorManager.register_select_cursor(%PlayButton, "mouse_entered", "mouse_exited")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%PlayButton.self_modulate.h += 0.1 * delta
	trigger_play_button_anim()
	pass


func _on_play_button_pressed() -> void:
	LevelsController.load_level_list()
	pass


func trigger_play_button_anim() :
	var m_pos := get_viewport().get_mouse_position()
	var reaction_dist := 400
	var control_center = %Outline.global_position + %Outline.size/2
	var clamped_dist_2_mouse = clamp(m_pos.distance_to(control_center), 0, reaction_dist)
	var normalized_d_2_m = clamped_dist_2_mouse/reaction_dist
	var complement = 1. - normalized_d_2_m
	# Outline scale
	%Outline.custom_minimum_size = Vector2(75, 82) + Vector2(75, 82) * 0.5  * complement
	# Outline container transform
	$OutlineContainer.pivot_offset = %Outline.custom_minimum_size/2
	$OutlineContainer.rotation = complement/1.5
	# PlayButton container transform
	$PlayButtonContainer.pivot_offset = %PlayButton.custom_minimum_size/2
	$PlayButtonContainer.scale = Vector2.ONE + Vector2(0.3, 0.3) * complement

	
