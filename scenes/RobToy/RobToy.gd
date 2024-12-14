@tool
extends CharacterBody2D
class_name RobToy

enum FACING_DIR {UP=0, RIGHT=1, DOWN=2, LEFT=3}

@export var initial_dir : FACING_DIR = FACING_DIR.DOWN
@export var move_time := 1

@onready var explosion_parts := %ExplosionParts

var direction := Vector2.ZERO
var level_node : Level

func _ready() -> void:
	# get_level_node()
	match initial_dir:
		FACING_DIR.UP :
			change_direction(Vector2.UP)
		FACING_DIR.RIGHT :
			change_direction(Vector2.RIGHT)
		FACING_DIR.DOWN :
			change_direction(Vector2.DOWN)
		FACING_DIR.LEFT :
			change_direction(Vector2.LEFT)
		_:
			pass
	move()

# func get_level_node() :
# 	var node = get_node_or_null('../..')
# 	if node and node is Level :
# 		level_node = node

func move() :
	if Engine.is_editor_hint() :
		return
	var next_position = position + direction
	look_at(global_position+direction)
	var tween := create_tween()
	tween.tween_property(self, "position", next_position, move_time).set_delay(0)
	tween.tween_callback(move)


func change_direction(new_dir:Vector2) :
	direction = new_dir.normalized() * 200

func closer_valid_position(of:Vector2) :
	var valid : Vector2 = snapped(of, Vector2(200, 200))
	return valid

func exit_map() :
	queue_free()

func _on_contact_area_body_entered(body:Node2D) -> void:
	if body == self or body.owner == self :
		return
	var from  = body.global_position
	if body is StaticBody2D :
		from = global_position + direction
	destroy(from)

func destroy(from:Vector2=Vector2.ZERO) :
	$RobToyCollisionShape.set_deferred('disabled', true)
	explosion_parts.detach(get_parent())
	explosion_parts.explode(from)
	queue_free()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint() :
		global_position = snapped(global_position, Vector2(200, 200))
		match initial_dir:
			FACING_DIR.UP :
				look_at(global_position + Vector2.UP)
			FACING_DIR.RIGHT :
				look_at(global_position + Vector2.RIGHT)
			FACING_DIR.DOWN :
				look_at(global_position + Vector2.DOWN)
			FACING_DIR.LEFT :
				look_at(global_position + Vector2.LEFT)
			_:
				pass
