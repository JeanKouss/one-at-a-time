@tool
extends Area2D

enum FACING_DIR { UP=0, RIGHT=1, DOWN=2, LEFT=3 }

@export var facing : FACING_DIR = FACING_DIR.RIGHT :
	set(value) :
		match value:
			FACING_DIR.UP :
				direction = Vector2.UP
			FACING_DIR.RIGHT :
				direction = Vector2.RIGHT
			FACING_DIR.DOWN :
				direction = Vector2.DOWN
			FACING_DIR.	LEFT :
				direction = Vector2.	LEFT
			_:
				pass
		facing = value

var direction : Vector2 = Vector2.RIGHT :
	set(value) :
		update_body(direction, value)
		direction = value.normalized()
var focused := false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Engine.is_editor_hint() :
		global_position = snapped(global_position, Vector2(200, 200))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("next") and focused :
		next_dir()

func update_body(from:Vector2, to:Vector2) :
	var tween = create_tween()
	tween.tween_method($Body/Arrow.look_at, from, to, 0.2)
	
func next_dir() :
	direction = direction.rotated(PI/2)

func _on_body_entered(body:Node2D) -> void:
	if not body is RobToy :
		return
	(body as RobToy).change_direction(direction)

func _on_mouse_entered() -> void:
	focused = true

func _on_mouse_exited() -> void:
	focused = false
