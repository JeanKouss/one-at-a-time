extends Node2D
class_name Level

@export var min_toy_to_exit : int = 1

var exited_toys : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func register_exit_portal(portal) :
	portal.robtoy_exited.connect(_on_toy_exited)
	pass

func _on_toy_exited(_toy) :
	print('another one')
	exited_toys += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func level_passed() :
	if exited_toys < min_toy_to_exit :
		return false
	return true
