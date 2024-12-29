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
var body_tween : Tween
var direction : Vector2 = Vector2.RIGHT :
	set(value) :
		update_body(direction, value)
		direction = value.normalized()

var toys_entered : Array[RobToy] = []
var locked : = false

var focused := false :
	set(value) :
		if locked and value==false :
			focused = false
			return
		focused = value
		if focused : _focus_entered()
		else : _focus_exited()


func _ready() -> void:
	if not Engine.is_editor_hint() :
		CursorManager.register_rotation_cursor(self, "mouse_entered", "mouse_exited")
	pass

func _process(_delta: float) -> void:
	%DirArrows.material.set_shader_parameter("modulate", $Body.modulate)
	if Engine.is_editor_hint() :
		global_position = snapped(global_position, Vector2(200, 200))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("next") and focused :
		next_dir()

func update_body(_from:Vector2, to:Vector2) :
	# $Body/ArrowMask.look_at(to)
	var to_point = global_position + to
	var form_point = global_position + _from
	var tw := create_tween()
	tw.tween_method(%DirArrows.look_at, form_point, to_point, 0.1)
	
func next_dir() :
	if locked :
		return
	AudioPlayerManager.dirChanged()
	direction = direction.rotated(PI/2)

func _on_mouse_entered() -> void:
	focused = true

func _on_mouse_exited() -> void:
	focused = false


func _on_body_entered(body:Node2D) -> void:
	if not body is RobToy :
		return
	toys_entered.append(body)
	(body as RobToy).change_direction(direction)
	lock(true)

func _on_body_exited(body:Node2D) -> void:
	if not body is RobToy :
		return
	toys_entered.erase(body)
	if toys_entered.is_empty() :
		unlock()

func _focus_entered() :
	AudioPlayerManager.dirFocused()
	var mod_col : Color = Color('#0094C6') * 3.
	mod_col.a = 1.0
	$Body/Background.visible = true
	if body_tween and body_tween.is_valid() :
		body_tween.kill()
	body_tween = create_tween().set_parallel(true)
	body_tween.tween_property($Body, 'modulate', mod_col, 0.1)
	body_tween.tween_property($Body/Background, 'scale', Vector2.ONE * 1.1, 0.1)
	

func _focus_exited() :
	if locked :
		return
	if body_tween and body_tween.is_valid() :
		body_tween.kill()
	body_tween = create_tween().set_parallel(true)
	body_tween.tween_property($Body, 'modulate', Color('#FFF'), 0.1)
	body_tween.tween_property($Body/Background, 'scale', Vector2.ONE, 0.1)
	body_tween.chain().tween_property($Body/Background, 'visible', false, 0.0)

func lock(_stepped:bool=true) :
	locked = true
	$Body.modulate = Color('#0FFF95') * 3
	$Body.modulate.a = 1.0
	# material.set_shader_parameter("some_value", some_value)
	$Body/Background.scale = Vector2.ONE
	$Body/Background.visible = true
	AudioPlayerManager.dirLocked()

func unlock() :
	locked = false
	$Body.modulate = Color('#FFF')
	$Body/Background.scale = Vector2.ONE
	$Body/Background.visible = false
