extends TouchScreenButton

@onready var button : BaseButton = get_parent()

# func _ready() -> void:
#     if not button.is_node_ready() :
#         await button.ready
#         var connections = button.pressed.get_connections()
#         for con in connections:
#             pressed.connect(con.callable)

func _on_pressed() -> void:
    button.pressed.emit()
