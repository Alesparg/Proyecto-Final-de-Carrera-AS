extends Area2D

@export var speed: float = 480.0
@export var damage: int = 1
@export var hit_radius: float = 16.0

var _target: Area2D
var _splash_radius: float = 0.0
var _life_left: float = 3.0


func _ready() -> void:
	monitoring = true
	area_entered.connect(_on_area_entered)


func setup(enemy_target: Area2D, projectile_damage: int, splash_radius: float = 0.0) -> void:
	_target = enemy_target
	damage = projectile_damage
	_splash_radius = splash_radius
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
			primary.take_damage(damage)
	else:
		for enemy in get_tree().get_nodes_in_group("td_enemies"):
			if not is_instance_valid(enemy):
				continue
			if enemy.global_position.distance_to(impact_pos) <= _splash_radius:
				enemy.take_damage(damage)

	queue_free()
