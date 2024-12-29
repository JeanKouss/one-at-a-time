extends Node


func _ready() -> void:
	pass

func click() -> void:
	$Click.play()

func dirChanged() -> void:
	$DirPanelChange.play()

func dirFocused() -> void:
	$DirChangerSelected.play()

func dirLocked() -> void:
	$DirChangerLocked.play()