extends Node2D

signal robtoy_exited(rt:RobToy)

@export var lev_node : Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func register_to_level() :
	lev_node.register_exit_portal(self)

func _on_exit_confirmation_area_body_entered(body:Node2D) -> void:
	if not body is RobToy :
		return
	robtoy_exited.emit(body)
	(body as RobToy).exit_map()