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
		direction = value.normalized()
		update_body()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_body() :
	$Body/Arrow.look_at(position+direction)

func _on_body_entered(body:Node2D) -> void:
	if not body is RobToy :
		return
	(body as RobToy).change_direction(direction)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint() :
		global_position = snapped(global_position, Vector2(200, 200))