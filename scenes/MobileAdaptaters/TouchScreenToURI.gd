extends TouchScreenButton

@onready var button : LinkButton = get_parent()

func _on_pressed() -> void:
    OS.shell_open(button.uri)
