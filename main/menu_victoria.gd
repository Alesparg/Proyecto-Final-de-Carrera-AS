extends Control

var next_level: int = 1

func _ready() -> void:
	print("Menú de victoria inicializado, nivel siguiente: ", next_level)
	# Conectar los botones a sus funciones
	if has_node("VBoxContainer/NextLevelButton"):
		$VBoxContainer/NextLevelButton.pressed.connect(_on_next_level_pressed)
		print("Botón NextLevel conectado")
	if has_node("VBoxContainer/ExitButton"):
		$VBoxContainer/ExitButton.pressed.connect(_on_exit_pressed)
		print("Botón Exit conectado")
	
	# Actualizar el texto del botón según el nivel siguiente
	_update_button_text()

func set_next_level(level: int) -> void:
	next_level = level
	_update_button_text()

func _update_button_text() -> void:
	if has_node("VBoxContainer/NextLevelButton"):
		if next_level <= 5:
			$VBoxContainer/NextLevelButton.text = "Jugar Nivel %d" % next_level
		else:
			$VBoxContainer/NextLevelButton.text = "Juego Completado"
			$VBoxContainer/NextLevelButton.disabled = true

func _on_next_level_pressed() -> void:
	if next_level <= 4:
		Globals.set_level(next_level)
		get_tree().change_scene_to_file("res://main/colworld.tscn")

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://main/menu_inicio.tscn")
