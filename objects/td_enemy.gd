extends Area2D

signal died(enemy: Area2D)
signal reached_base(enemy: Area2D)

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
	var actual := maxi(1, amount - armor)
	health -= actual
	_update_health_bar()
	if health <= 0:
		died.emit(self)
		queue_free()


func _update_health_bar() -> void:
	if has_node("HealthBar"):
		var ratio := clampf(float(health) / float(max_health), 0.0, 1.0)
		$HealthBar.scale.x = ratio
