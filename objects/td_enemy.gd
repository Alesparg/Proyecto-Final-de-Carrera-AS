extends Area2D

signal died(enemy: Area2D)
signal reached_base(enemy: Area2D)

# Categorías de enemigos para el sistema de ventajas/resistencias
const ENEMY_CATEGORIES := {
	"basic": "normal_enemy_1",    # Enemigo normal 1 (rojo) - equilibrado
	"runner": "fast_small",      # Enemigo rápido pequeño - vulnerable a calibre pequeño
	"tank": "armored_tank",      # Tanque blindado - resistente a calibre pequeño
	"brute": "normal_enemy_2",    # Enemigo normal 2 (morado) - equilibrado
	"shield": "shield_enemy",    # Enemigo con escudo - resistente a pequeño/medio
	"swarm": "swarm_enemy",      # Enjambre - grupo de criaturas pequeñas - vulnerable a calibre pequeño
}

# Multiplicadores de daño según categoría de torreta vs categoría de enemigo
const DAMAGE_MULTIPLIERS := {
	"small_caliber": {
		"fast_small": 1.5,         # x1.5 contra rápidos
		"normal_enemy_1": 1.0,     # x1.0 contra normales
		"normal_enemy_2": 1.0,     # x1.0 contra normales
		"armored_tank": 0.3,       # x0.3 contra blindados
		"shield_enemy": 0.4,       # x0.4 contra escudo (poco daño)
		"vulnerable_enemy": 1.2,   # x1.2 contra enemigo sin escudo (bonus)
	},
	"medium_caliber": {
		"fast_small": 1.0,         # x1.0 contra rápidos
		"normal_enemy_1": 1.0,     # x1.0 contra normales
		"normal_enemy_2": 1.0,     # x1.0 contra normales
		"armored_tank": 0.7,       # x0.7 contra blindados
		"shield_enemy": 0.5,       # x0.5 contra escudo (poco daño)
		"vulnerable_enemy": 1.3,   # x1.3 contra enemigo sin escudo (bonus)
	},
	"large_caliber": {
		"fast_small": 0.5,         # x0.5 contra rápidos (difícil por velocidad)
		"normal_enemy_1": 1.2,     # x1.2 contra normales
		"normal_enemy_2": 1.2,     # x1.2 contra normales
		"armored_tank": 2.0,       # x2.0 contra blindados
		"shield_enemy": 2.0,       # x2.0 contra escudo (excelente)
		"vulnerable_enemy": 0.8,   # x0.8 contra enemigo sin escudo (menos efectivo)
	},
}

const TYPE_DEFS := {
	"basic": {
		"health_mult": 1.0,
		"speed_mult": 1.0,
		"reward_mult": 1.0,
		"damage": 1,
		"armor": 0,
		"color": Color(0.95, 0.25, 0.2),
		"scale": 1.0,
		"tag": "",
	},
	"runner": {
		"health_mult": 0.55,
		"speed_mult": 1.55,
		"reward_mult": 0.85,
		"damage": 1,
		"armor": 0,
		"color": Color(1.0, 0.55, 0.15),
		"scale": 0.82,
		"tag": "R",
	},
	"tank": {
		"health_mult": 2.6,
		"speed_mult": 0.52,
		"reward_mult": 1.35,
		"damage": 2,
		"armor": 1,
		"color": Color(0.55, 0.58, 0.65),
		"scale": 1.38,
		"tag": "T",
	},
	"brute": {
		"health_mult": 1.45,
		"speed_mult": 0.82,
		"reward_mult": 1.15,
		"damage": 4,
		"armor": 0,
		"color": Color(0.72, 0.22, 0.85),
		"scale": 1.12,
		"tag": "B",
	},
	"shield": {
		"health_mult": 1.0,        # Vida normal
		"speed_mult": 0.9,         # Velocidad ligeramente reducida por el escudo
		"reward_mult": 1.3,        # Mayor recompensa por el escudo
		"damage": 2,
		"armor": 0,
		"shield_mult": 1.0,       # Multiplicador de vida del escudo
		"color": Color(0.4, 0.6, 0.9),  # Azul pálido
		"scale": 1.1,
		"tag": "S",
	},
	"swarm": {
		"health_mult": 0.25,       # Vida muy baja (cada criatura individual)
		"speed_mult": 1.2,         # Velocidad moderadamente alta
		"reward_mult": 0.3,        # Baja recompensa por criatura individual
		"damage": 1,
		"armor": 0,
		"color": Color(0.9, 0.9, 0.3),  # Amarillo pálido
		"scale": 0.6,              # Muy pequeño
		"tag": "W",
	},
}

@export var speed: float = 80.0
@export var max_health: int = 6
@export var credit_reward: int = 15
@export var base_damage: int = 1

var enemy_type: String = "basic"
var armor: int = 0
var path: Path2D
var progress: float = 0.0
var health: int = 0

# Sistema de escudo
var shield_health: int = 0
var max_shield_health: int = 0
var has_shield: bool = false


func _ready() -> void:
	health = max_health
	add_to_group("td_enemies")


func configure_from_wave(type_id: String, enemy_path: Path2D, wave: Dictionary) -> void:
	path = enemy_path
	enemy_type = type_id if TYPE_DEFS.has(type_id) else "basic"
	var def: Dictionary = TYPE_DEFS[enemy_type]

	var base_health: int = wave.get("health", 3)
	var base_speed: float = wave.get("speed", 65.0)
	var base_reward: int = wave.get("reward", 12)

	speed = base_speed * def.speed_mult
	max_health = maxi(1, int(round(base_health * def.health_mult)))
	health = max_health
	credit_reward = maxi(1, int(round(base_reward * def.reward_mult)))
	base_damage = def.damage
	armor = def.armor

	# Inicializar escudo si es enemigo con escudo
	if enemy_type == "shield":
		has_shield = true
		max_shield_health = max_health  # Escudo tiene la misma vida que el enemigo
		shield_health = max_shield_health
		_update_shield_bar()
	else:
		has_shield = false
		shield_health = 0
		max_shield_health = 0

	scale = Vector2.ONE * def.scale
	_apply_visual(def)
	_update_health_bar()
	_sync_position_to_path()


func setup(enemy_path: Path2D, enemy_speed: float, enemy_health: int, reward: int, damage: int) -> void:
	configure_from_wave("basic", enemy_path, {
		"health": enemy_health,
		"speed": enemy_speed,
		"reward": reward,
	})
	base_damage = damage


func _apply_visual(def: Dictionary) -> void:
	if has_node("Sprite2D"):
		$Sprite2D.modulate = def.color
	if has_node("TypeTag"):
		$TypeTag.text = def.tag
		$TypeTag.visible = def.tag != ""


func _sync_position_to_path() -> void:
	if path == null or path.curve == null:
		return
	var sample := maxf(0.0, progress)
	global_position = path.global_position + path.curve.sample_baked(sample)


func _physics_process(delta: float) -> void:
	if path == null or path.curve == null:
		return

	progress += speed * delta
	var path_length := path.curve.get_baked_length()
	if progress >= path_length:
		reached_base.emit(self)
		queue_free()
		return

	global_position = path.global_position + path.curve.sample_baked(maxf(0.0, progress))


func take_damage(amount: int = 1) -> void:
	# Si tiene escudo, el daño va primero al escudo
	if has_shield and shield_health > 0:
		var shield_damage = amount
		shield_health -= shield_damage
		_update_shield_bar()
		
		# Si el escudo se rompe, el enemigo queda vulnerable
		if shield_health <= 0:
			has_shield = false
			shield_health = 0
			_update_shield_bar()
			# Quitar la barra de escudo visualmente
			if has_node("ShieldBar"):
				$ShieldBar.visible = false
		return  # El escudo absorbió todo el daño
	
	# Si no tiene escudo o el escudo está roto, aplicar daño normal
	var actual := maxi(1, amount - armor)
	health -= actual
	_update_health_bar()
	if health <= 0:
		died.emit(self)
		queue_free()


func get_enemy_category() -> String:
	# Si el escudo está roto, el enemigo se vuelve vulnerable a pequeño/medio
	if enemy_type == "shield" and not has_shield:
		return "vulnerable_enemy"  # Categoría especial para enemigo sin escudo
	return ENEMY_CATEGORIES.get(enemy_type, "normal_enemy_1")


func _update_shield_bar() -> void:
	if has_node("ShieldBar"):
		var ratio := clampf(float(shield_health) / float(max_shield_health), 0.0, 1.0)
		$ShieldBar.scale.x = ratio
		$ShieldBar.visible = has_shield


func _update_health_bar() -> void:
	if has_node("HealthBar"):
		var ratio := clampf(float(health) / float(max_health), 0.0, 1.0)
		$HealthBar.scale.x = ratio
