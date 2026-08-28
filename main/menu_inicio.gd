extends Control

func _ready() -> void:
	# Conectar los botones a sus funciones
	if has_node("VBoxContainer/JugarButton"):
		$VBoxContainer/JugarButton.pressed.connect(_on_jugar_pressed)
	if has_node("VBoxContainer/SalirButton"):
		$VBoxContainer/SalirButton.pressed.connect(_on_salir_pressed)

func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://main/colworld.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
