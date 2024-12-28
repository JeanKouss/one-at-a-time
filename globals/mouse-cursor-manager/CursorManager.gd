extends Node

var normal : = load("res://assets/textures/cursors/pointer_c.png")
var pointer_cursor : = load("res://assets/textures/cursors/hand_small_point.png")
var rotate_cursor : = load("res://assets/textures/cursors/rotate_cw.png")

# var current_cursor_type_responsible

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(normal)


# func _process(delta: float) -> void:
# 	pass


func register_select_cursor(emitter, enter_signal, exit_signal) -> void:
	emitter.connect(enter_signal, self.change_cursor_to.bind(pointer_cursor, Vector2(18, 12)))
	emitter.connect(exit_signal, self.change_cursor_to_default)
	emitter.tree_exiting.connect(change_cursor_to_default)


func register_rotation_cursor(emitter, enter_signal, exit_signal) -> void:
	emitter.connect(enter_signal, self.change_cursor_to.bind(rotate_cursor, Vector2(32, 32)))
	emitter.connect(exit_signal, self.change_cursor_to_default)
	emitter.tree_exiting.connect(change_cursor_to_default)


func change_cursor_to(new_cursor, hspot=Vector2.ZERO):
	Input.set_custom_mouse_cursor(new_cursor, Input.CursorShape.CURSOR_ARROW, hspot)

func change_cursor_to_default() :
	Input.set_custom_mouse_cursor(normal)
