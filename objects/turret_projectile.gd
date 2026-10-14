extends Area2D

@export var speed: float = 480.0
@export var damage: int = 1
@export var hit_radius: float = 16.0

var _target: Area2D
var _splash_radius: float = 0.0
var _life_left: float = 3.0
var _turret_category: String = "medium_caliber"  # Categoría de la torreta que disparó


func _ready() -> void:
	monitoring = true
	area_entered.connect(_on_area_entered)


func setup(enemy_target: Area2D, projectile_damage: int, splash_radius: float = 0.0, turret_category: String = "medium_caliber") -> void:
	_target = enemy_target
	damage = projectile_damage
	_splash_radius = splash_radius
	_turret_category = turret_category
	if _target != null and is_instance_valid(_target):
		_aim_at(_target.global_position)


func _physics_process(delta: float) -> void:
	if not is_instance_valid(_target):
		queue_free()
		return

	var to_target := _target.global_position - global_position
	var dist := to_target.length()
	if dist <= hit_radius:
		_apply_hit(_target)
		return

	var direction := to_target / dist
	global_position += direction * speed * delta
	_aim_at(_target.global_position)

	_life_left -= delta
	if _life_left <= 0.0:
		queue_free()


func _aim_at(world_pos: Vector2) -> void:
	rotation = (world_pos - global_position).angle()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("td_enemies"):
		_apply_hit(area)


func _apply_hit(primary: Area2D) -> void:
	var impact_pos := global_position
	if primary != null and is_instance_valid(primary):
		impact_pos = primary.global_position

	if _splash_radius <= 0.0:
		if primary != null and is_instance_valid(primary) and primary.has_method("take_damage"):
			var final_damage = _calculate_damage(primary)
			primary.take_damage(final_damage)
	else:
		for enemy in get_tree().get_nodes_in_group("td_enemies"):
			if not is_instance_valid(enemy):
				continue
			if enemy.global_position.distance_to(impact_pos) <= _splash_radius:
				var final_damage = _calculate_damage(enemy)
				enemy.take_damage(final_damage)

	queue_free()


func _calculate_damage(enemy: Area2D) -> int:
	# Obtener multiplicador de daño basado en categorías
	var multiplier = 1.0
	
	if enemy.has_method("get_enemy_category"):
		var enemy_category = enemy.get_enemy_category()
		multiplier = _get_damage_multiplier(_turret_category, enemy_category)
	
	return int(round(damage * multiplier))


func _get_damage_multiplier(turret_cat: String, enemy_cat: String) -> float:
	# Multiplicadores de daño según categoría de torreta vs categoría de enemigo
	match turret_cat:
		"small_caliber":
			match enemy_cat:
				"fast_small": return 1.5
				"normal_enemy_1": return 1.0
				"normal_enemy_2": return 1.0
				"armored_tank": return 0.3
				"shield_enemy": return 0.4
				"vulnerable_enemy": return 1.2
				"swarm_enemy": return 2.5  # Muy efectivo contra enjambre
				_: return 1.0
		"medium_caliber":
			match enemy_cat:
				"fast_small": return 1.0
				"normal_enemy_1": return 1.0
				"normal_enemy_2": return 1.0
				"armored_tank": return 0.7
				"shield_enemy": return 0.5
				"vulnerable_enemy": return 1.3
				"swarm_enemy": return 0.8  # Menos efectivo contra enjambre
				_: return 1.0
		"large_caliber":
			match enemy_cat:
				"fast_small": return 0.5
				"normal_enemy_1": return 1.2
				"normal_enemy_2": return 1.2
				"armored_tank": return 2.0
				"shield_enemy": return 2.0
				"vulnerable_enemy": return 0.8
				"swarm_enemy": return 0.4  # Muy poco efectivo contra enjambre
				_: return 1.0
		_: return 1.0
