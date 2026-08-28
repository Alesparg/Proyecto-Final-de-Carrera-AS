extends Node2D

signal upgraded(turret: Node2D)

const MAX_LEVEL := 3
const UPGRADE_COSTS := [0, 120, 150]

@export var turret_id: String = "basic"
@export var display_name: String = "Basica"
@export var build_cost: int = 50
@export var attack_range: float = 210.0
@export var fire_rate: float = 0.75
@export var damage: int = 0
@export var splash_radius: float = 0.0
@export var range_indicator_base: float = 210.0
@export var projectile_scene: PackedScene

var level: int = 1
var _cooldown: float = 0.0


func _ready() -> void:
	_update_visuals()


func _process(delta: float) -> void:
	_cooldown -= delta
	if _cooldown > 0.0:
		return

	var target := _find_target()
	if target != null:
		_shoot(target)
		_cooldown = fire_rate


func get_upgrade_cost() -> int:
	if level >= MAX_LEVEL:
		return -1
	return UPGRADE_COSTS[level]


func can_upgrade() -> bool:
	return level < MAX_LEVEL


func upgrade() -> void:
	if not can_upgrade():
		return
	level += 1
	damage += 1
	attack_range += 25.0
	if splash_radius > 0.0:
		splash_radius += 8.0
	fire_rate = maxf(0.35, fire_rate - 0.15)
	_update_visuals()
	upgraded.emit(self)


func _find_target() -> Area2D:
	var best_target: Area2D = null
	var best_progress := -1.0

	for enemy in get_tree().get_nodes_in_group("td_enemies"):
		if not is_instance_valid(enemy):
			continue
		var dist := global_position.distance_to(enemy.global_position)
		if dist > attack_range:
			continue
		if enemy.progress > best_progress:
			best_progress = enemy.progress
			best_target = enemy

	return best_target


func _shoot(target: Area2D) -> void:
	if projectile_scene == null:
		return

	var projectile := projectile_scene.instantiate()
	get_tree().current_scene.get_node("Projectiles").add_child(projectile)
	projectile.global_position = global_position
	if projectile.has_method("setup"):
		projectile.setup(target, damage, splash_radius)

	if has_node("Barrel"):
		$Barrel.look_at(target.global_position)


func _update_visuals() -> void:
	if has_node("RangeIndicator") and range_indicator_base > 0.0:
		$RangeIndicator.scale = Vector2.ONE * (attack_range / range_indicator_base)
	if has_node("LevelLabel"):
		$LevelLabel.text = str(level)
