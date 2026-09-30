extends Node2D

const LEVEL_CONFIGS := {
	1: {
		"path_points": [
			Vector2(64, 512),
			Vector2(64, 128),
			Vector2(320, 128),
			Vector2(320, 512),
			Vector2(576, 512),
			Vector2(576, 128),
			Vector2(832, 128),
			Vector2(832, 512),
		],
		"turret_slot_positions": [
			Vector2(192, 320),
			Vector2(192, 640),
			Vector2(448, 224),
			Vector2(448, 416),
			Vector2(448, 640),
			Vector2(704, 320),
			Vector2(704, 640),
			Vector2(896, 320),
		],
		"base_position": Vector2(832, 512),
	},
	2: {
		"path_points": [
			Vector2(64, 320),
			Vector2(192, 320),
			Vector2(192, 128),
			Vector2(448, 128),
			Vector2(448, 512),
			Vector2(704, 512),
			Vector2(704, 128),
			Vector2(960, 128),
			Vector2(960, 512),
		],
		"turret_slot_positions": [
			Vector2(128, 416),
			Vector2(128, 224),
			Vector2(320, 224),
			Vector2(320, 416),
			Vector2(576, 224),
			Vector2(576, 416),
			Vector2(832, 224),
			Vector2(832, 416),
		],
		"base_position": Vector2(960, 512),
	},
	3: {
		"path_points": [
			Vector2(512, 640),  # Start from bottom center
			Vector2(512, 480),
			Vector2(320, 480),
			Vector2(320, 320),
			Vector2(704, 320),
			Vector2(704, 160),
			Vector2(896, 160), # Exit top right
		],
		"turret_slot_positions": [
			Vector2(416, 560),
			Vector2(608, 400),
			Vector2(224, 240),
			Vector2(800, 240),
			Vector2(224, 400),
			Vector2(768, 400),
			Vector2(512, 80),
			Vector2(576, 560),
		],
		"base_position": Vector2(896, 160),
	},
	4: {
		"path_points": [
			Vector2(64, 640),  # Start from bottom left
			Vector2(64, 480),
			Vector2(320, 480),
			Vector2(320, 320),
			Vector2(192, 320),
			Vector2(192, 160),
			Vector2(512, 160),
			Vector2(512, 320),
			Vector2(704, 320),
			Vector2(704, 480),
			Vector2(960, 480), # Exit right
		],
		"turret_slot_positions": [
			Vector2(128, 560),
			Vector2(256, 400),
			Vector2(384, 400),
			Vector2(128, 240),
			Vector2(384, 240),
			Vector2(576, 240),
			Vector2(576, 400),
			Vector2(832, 400),
			Vector2(832, 560),
		],
		"base_position": Vector2(960, 480),
	},
	5: {
		"path_points": [
			Vector2(64, 320),    # Entrada principal
			Vector2(256, 320),   # Punto de bifurcación
		],
		"upper_path": [        # Camino superior (línea roja)
			Vector2(256, 160),
			Vector2(384, 160),
			Vector2(512, 160),
			Vector2(640, 160),
			Vector2(768, 160),
			Vector2(768, 320),
		],
		"lower_path": [        # Camino inferior (línea naranja)
			Vector2(256, 480),
			Vector2(384, 480),
			Vector2(512, 480),
			Vector2(640, 480),
			Vector2(768, 480),
			Vector2(768, 320),
		],
		"final_path": [        # Camino final después de reunión
			Vector2(768, 320),
			Vector2(832, 320),
			Vector2(832, 512),
		],
		"turret_slot_positions": [
			Vector2(160, 240),
			Vector2(160, 400),
			Vector2(320, 240),
			Vector2(320, 400),
			Vector2(512, 240),
			Vector2(512, 400),
			Vector2(704, 240),
			Vector2(704, 400),
		],
		"base_position": Vector2(832, 512),
	},
}

var current_level: int = 1
var PATH_POINTS: Array = []
var TURRET_SLOT_POSITIONS: Array = []

const WAVES := [
	{"count": 5, "interval": 2.2, "health": 6, "speed": 65.0, "reward": 6, "mix": {"basic": 1.0}},
	{"count": 8, "interval": 1.9, "health": 9, "speed": 68.0, "reward": 7, "mix": {"basic": 0.65, "runner": 0.35}},
	{"count": 10, "interval": 1.6, "health": 12, "speed": 72.0, "reward": 8, "mix": {"basic": 0.45, "runner": 0.35, "tank": 0.2}},
	{"count": 12, "interval": 1.4, "health": 15, "speed": 76.0, "reward": 9, "mix": {"basic": 0.3, "runner": 0.25, "tank": 0.25, "brute": 0.2}},
	{"count": 15, "interval": 1.2, "health": 18, "speed": 80.0, "reward": 10, "mix": {"basic": 0.2, "runner": 0.25, "tank": 0.3, "brute": 0.25}},
]

const SPAWN_STAGGER_DISTANCE := 56.0
const STARTING_CREDITS := 90

const TURRET_OPTIONS := [
	{"id": "basic", "scene": preload("res://objects/turret.tscn"), "label": "Basica", "cost": 50},
	{"id": "sniper", "scene": preload("res://objects/turret_sniper.tscn"), "label": "Francotirador", "cost": 90},
	{"id": "cannon", "scene": preload("res://objects/turret_cannon.tscn"), "label": "Canon", "cost": 75},
]

const ENEMY_SCENE := preload("res://objects/td_enemy.tscn")

@export var turret_slot_scene: PackedScene

@onready var path_2d: Path2D = $Path2D
@onready var base_node: Area2D = $Base
@onready var enemies_container: Node2D = $Enemies
@onready var turret_slots_container: Node2D = $TurretSlots
@onready var level_node: Node2D = $level

@onready var credits_label: Label = $ui/credits_label
@onready var wave_label: Label = $ui/wave_label
@onready var base_hp_label: Label = $ui/base_hp_label
@onready var message_label: Label = $ui/message_label
@onready var win_label: Label = $ui/youwin
@onready var game_over_label: Label = $ui/gameover
@onready var restart_button: Button = $ui/restart_button
@onready var hint_label: Label = $ui/hint_label
@onready var turret_bar: HBoxContainer = $ui/turret_bar
var next_level_button: Button
var exit_button: Button

var credits: int = STARTING_CREDITS
var current_wave: int = 0
var _selected_turret_index: int = 0
var _enemies_alive: int = 0
var _enemies_to_spawn: int = 0
var _spawn_timer: float = 0.0
var _wave_active: bool = false
var _between_waves: bool = false
var _between_wave_timer: float = 0.0
var _game_over: bool = false
var _game_won: bool = false
var _current_wave_data: Dictionary = {}
var _wave_spawn_index: int = 0
var _turret_pick_buttons: Array[Button] = []
var _enemy_path_alternator: bool = false  # Para alternar caminos en nivel 5
var _level5_enemy_index: int = 0  # Para enemigos deterministas en nivel 5


func _ready() -> void:
	current_level = Globals.get_level()
	_load_level_config()
	_setup_path()
	_spawn_turret_slots()
	_setup_turret_bar()
	_update_ui()
	_update_turret_bar_selection()

	base_node.base_destroyed.connect(_on_base_destroyed)
	base_node.health_changed.connect(_on_base_health_changed)

	if not restart_button.pressed.is_connected(_on_restart_button_pressed):
		restart_button.pressed.connect(_on_restart_button_pressed)

	base_hp_label.text = "Base: %d / %d" % [base_node.health, base_node.max_health]
	_start_next_wave()


func _load_level_config() -> void:
	if LEVEL_CONFIGS.has(current_level):
		var config: Dictionary = LEVEL_CONFIGS[current_level]
		PATH_POINTS = config.path_points
		TURRET_SLOT_POSITIONS = config.turret_slot_positions
		if config.has("base_position"):
			base_node.position = config.base_position
		
		# Cargar dinámicamente la escena del nivel correcto
		_load_level_scene()
	else:
		# Fallback al nivel 1 si no existe
		current_level = 1
		_load_level_config()


func _load_level_scene() -> void:
	# Eliminar el nivel actual si existe
	if level_node:
		level_node.queue_free()
	
	# Cargar la escena del nivel correspondiente
	var level_scene_path = "res://levels/level%d.tscn" % current_level
	var level_scene = load(level_scene_path)
	
	if level_scene:
		var new_level = level_scene.instantiate()
		new_level.name = "level"
		new_level.position = Vector2(1496, 404)  # Mantener la posición original
		add_child(new_level)
		level_node = new_level
		print("Nivel %d cargado: %s" % [current_level, level_scene_path])
	else:
		print("Error: No se pudo cargar el nivel %d" % current_level)


func set_level(level: int) -> void:
	current_level = level


func _unhandled_input(event: InputEvent) -> void:
	if _game_over or _game_won:
		return
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode >= KEY_1 and event.keycode <= KEY_3:
			var idx: int = event.keycode - KEY_1
			if idx < TURRET_OPTIONS.size():
				_select_turret_type(idx)


func _process(delta: float) -> void:
	if _game_over or _game_won:
		return

	if _between_waves:
		_between_wave_timer -= delta
		if _between_wave_timer <= 0.0:
			_start_next_wave()
		return

	if not _wave_active:
		return

	if _enemies_to_spawn > 0:
		_spawn_timer -= delta
		if _spawn_timer <= 0.0:
			_spawn_enemy()
			_enemies_to_spawn -= 1
			_spawn_timer = _current_wave_data.get("interval", 1.5)
	elif _enemies_alive <= 0:
		# Verificar que no haya enemigos válidos en el grupo
		var actual_enemies := 0
		for enemy in get_tree().get_nodes_in_group("td_enemies"):
			if is_instance_valid(enemy):
				actual_enemies += 1
		if actual_enemies <= 0:
			_finish_wave()


func _setup_path() -> void:
	var curve := Curve2D.new()
	for point in PATH_POINTS:
		curve.add_point(point)
	path_2d.curve = curve


func _setup_turret_bar() -> void:
	for i in TURRET_OPTIONS.size():
		var opt: Dictionary = TURRET_OPTIONS[i]
		var btn := Button.new()
		btn.text = "%s (%d)" % [opt.label, opt.cost]
		btn.toggle_mode = true
		btn.focus_mode = Control.FOCUS_NONE
		var idx: int = i
		btn.pressed.connect(func() -> void: _select_turret_type(idx))
		turret_bar.add_child(btn)
		_turret_pick_buttons.append(btn)
	_turret_pick_buttons[0].button_pressed = true


func _select_turret_type(index: int) -> void:
	_selected_turret_index = clampi(index, 0, TURRET_OPTIONS.size() - 1)
	_update_turret_bar_selection()
	var opt: Dictionary = TURRET_OPTIONS[_selected_turret_index]
	message_label.text = "Torreta seleccionada: %s" % opt.label


func _update_turret_bar_selection() -> void:
	for i in _turret_pick_buttons.size():
		_turret_pick_buttons[i].button_pressed = i == _selected_turret_index


func _spawn_turret_slots() -> void:
	for i in TURRET_SLOT_POSITIONS.size():
		var slot := turret_slot_scene.instantiate()
		slot.position = TURRET_SLOT_POSITIONS[i]
		slot.slot_index = i
		slot.slot_clicked.connect(_on_turret_slot_clicked)
		turret_slots_container.add_child(slot)


func _start_next_wave() -> void:
	if current_wave >= WAVES.size():
		_win_game()
		return

	_between_waves = false
	_wave_active = true
	_current_wave_data = WAVES[current_wave]
	_enemies_to_spawn = _current_wave_data["count"]
	_enemies_alive = 0
	_wave_spawn_index = 0
	var interval: float = _current_wave_data.get("interval", 1.5)
	_spawn_timer = interval

	current_wave += 1
	_update_ui()
	message_label.text = "Oleada %d en camino..." % current_wave


func _finish_wave() -> void:
	_wave_active = false
	if current_wave >= WAVES.size():
		_win_game()
		return

	_between_waves = true
	_between_wave_timer = 4.0
	message_label.text = "Oleada completada. Siguiente en 4s..."


func _pick_enemy_type() -> String:
	var mix: Dictionary = _current_wave_data.get("mix", {"basic": 1.0})
	var total_weight := 0.0
	for type_id in mix:
		total_weight += float(mix[type_id])
	if total_weight <= 0.0:
		return "basic"

	var threshold := randf() * total_weight
	var accumulated := 0.0
	for type_id in mix:
		accumulated += float(mix[type_id])
		if threshold <= accumulated:
			return str(type_id)
	return "basic"


func _spawn_enemy() -> void:
	var enemy_type: String
	
	# Lógica especial para nivel 5: enemigos deterministas
	if current_level == 5:
		enemy_type = _get_deterministic_enemy_type()
	else:
		enemy_type = _pick_enemy_type()
	
	var enemy: Area2D = ENEMY_SCENE.instantiate()
	enemies_container.add_child(enemy)
	
	# Lógica especial para nivel 5: alternar caminos deterministamente
	if current_level == 5:
		_setup_level5_path(enemy, enemy_type)
		_enemy_path_alternator = !_enemy_path_alternator  # Alternar para el siguiente enemigo
		_level5_enemy_index += 1  # Avanzar en la secuencia determinista
	else:
		enemy.configure_from_wave(enemy_type, path_2d, _current_wave_data)
	
	enemy.died.connect(_on_enemy_died)
	enemy.reached_base.connect(_on_enemy_reached_base)
	enemy.progress = -float(_wave_spawn_index) * SPAWN_STAGGER_DISTANCE
	_wave_spawn_index += 1
	_enemies_alive += 1


func _get_deterministic_enemy_type() -> String:
	# Secuencia determinista de enemigos para nivel 5
	# Máximo 3 tanques por ronda, patrón consistente
	
	var level5_enemy_sequences = [
		# Oleada 1: 5 enemigos básicos
		["basic", "basic", "basic", "basic", "basic"],
		
		# Oleada 2: 8 enemigos, mezcla controlada
		["basic", "basic", "basic", "basic", "runner", "runner", "basic", "basic"],
		
		# Oleada 3: 10 enemigos, 1 tanque máximo
		["basic", "basic", "runner", "runner", "basic", "tank", "basic", "runner", "basic", "basic"],
		
		# Oleada 4: 12 enemigos, 2 tanques máximo
		["basic", "runner", "basic", "tank", "runner", "basic", "basic", "tank", "runner", "basic", "basic", "runner"],
		
		# Oleada 5: 15 enemigos, 3 tanques máximo
		["basic", "runner", "tank", "basic", "runner", "basic", "tank", "runner", "basic", "brute", "basic", "runner", "tank", "basic", "runner"],
	]
	
	# Obtener la secuencia para la oleada actual (limitado a 5 oleadas)
	var wave_index = mini(current_wave - 1, level5_enemy_sequences.size() - 1)
	var sequence = level5_enemy_sequences[wave_index]
	
	# Obtener el tipo de enemigo basado en el índice actual
	var enemy_index = _level5_enemy_index % sequence.size()
	return sequence[enemy_index]


func _setup_level5_path(enemy: Area2D, enemy_type: String) -> void:
	var config: Dictionary = LEVEL_CONFIGS[5]
	var base_path = config.path_points
	var upper_path = config.upper_path
	var lower_path = config.lower_path
	var final_path = config.final_path
	
	# Construir el camino completo según el alternador
	var complete_path: Array = []
	
	# Camino inicial común
	for point in base_path:
		complete_path.append(point)
	
	# Alternar entre caminos superior e inferior
	if _enemy_path_alternator:
		# Camino superior (línea roja)
		for point in upper_path:
			complete_path.append(point)
	else:
		# Camino inferior (línea naranja)
		for point in lower_path:
			complete_path.append(point)
	
	# Camino final común
	for point in final_path:
		complete_path.append(point)
	
	# Crear Path2D temporal para este enemigo
	var temp_path = Path2D.new()
	var curve = Curve2D.new()
	for point in complete_path:
		curve.add_point(point)
	temp_path.curve = curve
	
	# Configurar el enemigo con el tipo correcto y el camino alternado
	enemy.configure_from_wave(enemy_type, temp_path, _current_wave_data)


func _on_enemy_died(enemy: Area2D) -> void:
	_enemies_alive = maxi(0, _enemies_alive - 1)
	_add_credits(enemy.credit_reward)


func _on_enemy_reached_base(enemy: Area2D) -> void:
	_enemies_alive = maxi(0, _enemies_alive - 1)
	base_node.take_damage(enemy.base_damage)


func _get_selected_turret_option() -> Dictionary:
	return TURRET_OPTIONS[_selected_turret_index]


func _on_turret_slot_clicked(slot: Area2D) -> void:
	if _game_over or _game_won:
		return

	if slot.is_occupied():
		var turret: Node2D = slot.turret
		if turret.has_method("can_upgrade") and turret.can_upgrade():
			var cost: int = turret.get_upgrade_cost()
			if credits >= cost:
				credits -= cost
				turret.upgrade()
				_update_ui()
				message_label.text = "Torreta mejorada (nivel %d)" % turret.level
			else:
				message_label.text = "Necesitas %d creditos para mejorar" % cost
		else:
			message_label.text = "Torreta al nivel maximo"
	else:
		var option := _get_selected_turret_option()
		var scene: PackedScene = option.scene
		var cost: int = option.cost
		if scene == null:
			return
		if credits >= cost:
			credits -= cost
			slot.place_turret(scene)
			_update_ui()
			message_label.text = "%s construida" % option.label
		else:
			message_label.text = "Necesitas %d creditos para %s" % [cost, option.label]


func _add_credits(amount: int) -> void:
	credits += amount
	_update_ui()


func _on_base_health_changed(current: int, maximum: int) -> void:
	base_hp_label.text = "Base: %d / %d" % [current, maximum]


func _on_base_destroyed() -> void:
	_lose_game()


func _win_game() -> void:
	_game_won = true
	_wave_active = false
	win_label.show()
	message_label.text = "Todas las oleadas superadas"
	hint_label.hide()
	
	# Crear botones de victoria directamente en la UI
	_create_victory_buttons()


func _lose_game() -> void:
	_game_over = true
	_wave_active = false
	game_over_label.show()
	restart_button.show()
	message_label.text = "La base fue destruida"
	hint_label.hide()


func _update_ui() -> void:
	credits_label.text = "Creditos: %d" % credits
	if current_wave == 0:
		wave_label.text = "Oleada: -"
	else:
		wave_label.text = "Oleada: %d / %d" % [current_wave, WAVES.size()]


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _create_victory_buttons() -> void:
	# Crear fondo negro para el menú
	var background = ColorRect.new()
	background.color = Color(0, 0, 0, 0.9)
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.z_index = 999
	$ui.add_child(background)
	
	# Crear contenedor para el menú
	var menu_container = VBoxContainer.new()
	menu_container.anchors_preset = Control.PRESET_CENTER
	menu_container.anchor_left = 0.5
	menu_container.anchor_top = 0.5
	menu_container.anchor_right = 0.5
	menu_container.anchor_bottom = 0.5
	menu_container.offset_left = -150
	menu_container.offset_top = -100
	menu_container.offset_right = 150
	menu_container.offset_bottom = 100
	menu_container.z_index = 1000
	$ui.add_child(menu_container)
	
	# Crear label de victoria
	var victory_label = Label.new()
	victory_label.text = "¡VICTORIA - Base Protegida!"
	victory_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	victory_label.add_theme_font_size_override("font_size", 32)
	victory_label.add_theme_color_override("font_color", Color(0.2, 1, 0.2))
	menu_container.add_child(victory_label)
	
	# Crear separador
	var separator = Control.new()
	separator.custom_minimum_size = Vector2(0, 30)
	menu_container.add_child(separator)
	
	# Crear botón de siguiente nivel
	next_level_button = Button.new()
	next_level_button.text = "Jugar Nivel %d" % (current_level + 1)
	next_level_button.custom_minimum_size = Vector2(250, 50)
	next_level_button.add_theme_font_size_override("font_size", 18)
	next_level_button.pressed.connect(_on_next_level_pressed)
	menu_container.add_child(next_level_button)
	
	# Crear separador
	var separator2 = Control.new()
	separator2.custom_minimum_size = Vector2(0, 15)
	menu_container.add_child(separator2)
	
	# Crear botón de salir
	exit_button = Button.new()
	exit_button.text = "Salir al Menú"
	exit_button.custom_minimum_size = Vector2(250, 50)
	exit_button.add_theme_font_size_override("font_size", 18)
	exit_button.pressed.connect(_on_exit_pressed)
	menu_container.add_child(exit_button)
	
	print("Menú de victoria creado con fondo negro")


func _on_next_level_pressed() -> void:
	if current_level + 1 <= 4:
		Globals.set_level(current_level + 1)
		get_tree().change_scene_to_file("res://main/colworld.tscn")


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://main/menu_inicio.tscn")
