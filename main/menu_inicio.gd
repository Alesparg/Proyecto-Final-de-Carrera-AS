extends Control

var selected_level: int = 1

func _ready() -> void:
	# Conectar los botones a sus funciones
	if has_node("VBoxContainer/Nivel1Button"):
		$VBoxContainer/Nivel1Button.pressed.connect(_on_nivel1_pressed)
	if has_node("VBoxContainer/Nivel2Button"):
		$VBoxContainer/Nivel2Button.pressed.connect(_on_nivel2_pressed)
	if has_node("VBoxContainer/Nivel3Button"):
		$VBoxContainer/Nivel3Button.pressed.connect(_on_nivel3_pressed)
	if has_node("VBoxContainer/Nivel4Button"):
		$VBoxContainer/Nivel4Button.pressed.connect(_on_nivel4_pressed)
	if has_node("VBoxContainer/Nivel5Button"):
		$VBoxContainer/Nivel5Button.pressed.connect(_on_nivel5_pressed)
	if has_node("VBoxContainer/JugarButton"):
		$VBoxContainer/JugarButton.pressed.connect(_on_jugar_pressed)
	if has_node("VBoxContainer/SalirButton"):
		$VBoxContainer/SalirButton.pressed.connect(_on_salir_pressed)
	
	_update_nivel_selection()

func _on_nivel1_pressed() -> void:
	selected_level = 1
	_update_nivel_selection()

func _on_nivel2_pressed() -> void:
	selected_level = 2
	_update_nivel_selection()

func _on_nivel3_pressed() -> void:
	selected_level = 3
	_update_nivel_selection()

func _on_nivel4_pressed() -> void:
	selected_level = 4
	_update_nivel_selection()

func _on_nivel5_pressed() -> void:
	selected_level = 5
	_update_nivel_selection()

func _update_nivel_selection() -> void:
	if has_node("VBoxContainer/Nivel1Button"):
		$VBoxContainer/Nivel1Button.button_pressed = (selected_level == 1)
	if has_node("VBoxContainer/Nivel2Button"):
		$VBoxContainer/Nivel2Button.button_pressed = (selected_level == 2)
	if has_node("VBoxContainer/Nivel3Button"):
		$VBoxContainer/Nivel3Button.button_pressed = (selected_level == 3)
	if has_node("VBoxContainer/Nivel4Button"):
		$VBoxContainer/Nivel4Button.button_pressed = (selected_level == 4)
	if has_node("VBoxContainer/Nivel5Button"):
		$VBoxContainer/Nivel5Button.button_pressed = (selected_level == 5)

func _on_jugar_pressed() -> void:
	Globals.set_level(selected_level)
	get_tree().change_scene_to_file("res://main/colworld.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
