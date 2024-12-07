extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	for body in get_children() :
		body = (body as RigidBody2D)
		body.freeze = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func detach(to_parent:Node) :
	reparent.call_deferred(to_parent)

func explode(from:Vector2) :
	visible = true
	for body in get_children() :
		body = (body as RigidBody2D)
		body.set_deferred('freeze', false)
		var v2b = body.global_position - from
		body.apply_central_impulse.call_deferred(v2b.normalized() * 1000)