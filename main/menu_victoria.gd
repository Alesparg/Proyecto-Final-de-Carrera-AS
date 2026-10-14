extends Control

var next_level: int = 1
var stars_earned: int = 0
var base_health_remaining: int = 0

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
	# Mostrar estrellas ganadas
	_display_stars()

func set_next_level(level: int) -> void:
	next_level = level
	_update_button_text()

func set_stars(health_remaining: int) -> void:
	base_health_remaining = health_remaining
	# Calcular estrellas basadas en la vida restante
	if health_remaining >= 16:
		stars_earned = 3
	elif health_remaining >= 10:
		stars_earned = 2
	else:
		stars_earned = 1
	
	print("Estrellas ganadas: ", stars_earned, " con vida: ", health_remaining)

func _update_button_text() -> void:
	if has_node("VBoxContainer/NextLevelButton"):
		if next_level <= 5:
			$VBoxContainer/NextLevelButton.text = "Jugar Nivel %d" % next_level
		else:
			$VBoxContainer/NextLevelButton.text = "Juego Completado"
			$VBoxContainer/NextLevelButton.disabled = true

func _display_stars() -> void:
	# Crear contenedor para estrellas
	var stars_container = HBoxContainer.new()
	stars_container.name = "StarsContainer"
	
	# Añadir estrellas según las ganadas
	for i in range(3):
		var star_label = Label.new()
		if i < stars_earned:
			star_label.text = "⭐"  # Estrella dorada
			star_label.add_theme_color_override("font_color", Color(1, 0.8, 0, 1))  # Dorado
		else:
			star_label.text = "☆"  # Estrella vacía
			star_label.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5, 1))  # Gris
		
		star_label.add_theme_font_size_override("font_size", 32)
		stars_container.add_child(star_label)
	
	# Añadir contenedor al VBoxContainer
	if has_node("VBoxContainer"):
		$VBoxContainer.add_child(stars_container)
		# Mover el contenedor de estrellas después del título de victoria
		$VBoxContainer.move_child(stars_container, 1)

func _on_next_level_pressed() -> void:
	if next_level <= 5:
		Globals.set_level(next_level)
		get_tree().change_scene_to_file("res://main/colworld.tscn")

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://main/menu_inicio.tscn")
