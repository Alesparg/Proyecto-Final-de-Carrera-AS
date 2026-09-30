extends Node

var selected_level: int = 1

func set_level(level: int) -> void:
	selected_level = level

func get_level() -> int:
	return selected_level
