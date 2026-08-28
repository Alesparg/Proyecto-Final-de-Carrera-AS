extends Node2D

const PATH_POINTS := [
	Vector2(64, 512),
	Vector2(64, 128),
	Vector2(320, 128),
	Vector2(320, 512),
	Vector2(576, 512),
	Vector2(576, 128),
	Vector2(832, 128),
	Vector2(832, 512),
]

const TURRET_SLOT_POSITIONS := [
	Vector2(192, 320),
	Vector2(192, 640),
	Vector2(448, 224),
	Vector2(448, 416),
	Vector2(448, 640),
	Vector2(704, 320),
	Vector2(704, 640),
	Vector2(896, 320),
]

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

@onready var credits_label: Label = $ui/credits_label
@onready var wave_label: Label = $ui/wave_label
@onready var base_hp_label: Label = $ui/base_hp_label
@onready var message_label: Label = $ui/message_label
@onready var win_label: Label = $ui/youwin
@onready var game_over_label: Label = $ui/gameover
@onready var restart_button: Button = $ui/restart_button
@onready var hint_label: Label = $ui/hint_label
@onready var turret_bar: HBoxContainer = $ui/turret_bar

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


func _ready() -> void:
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
	var enemy_type := _pick_enemy_type()
	var enemy: Area2D = ENEMY_SCENE.instantiate()
	enemies_container.add_child(enemy)
	enemy.configure_from_wave(enemy_type, path_2d, _current_wave_data)
	enemy.died.connect(_on_enemy_died)
	enemy.reached_base.connect(_on_enemy_reached_base)
	enemy.progress = -float(_wave_spawn_index) * SPAWN_STAGGER_DISTANCE
	_wave_spawn_index += 1
	_enemies_alive += 1


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
