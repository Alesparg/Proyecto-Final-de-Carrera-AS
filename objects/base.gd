extends Area2D

signal base_destroyed
signal health_changed(current: int, maximum: int)

@export var max_health: int = 20

var health: int = 0

func _ready() -> void:
	health = max_health
	_update_visual()
	health_changed.emit(health, max_health)

func take_damage(amount: int) -> void:
	if health <= 0:
		return
	health = maxi(0, health - amount)
	_update_visual()
	health_changed.emit(health, max_health)
	if health <= 0:
		base_destroyed.emit()

func _update_visual() -> void:
	if has_node("HealthBar"):
		var ratio := clampf(float(health) / float(max_health), 0.0, 1.0)
		$HealthBar.scale.x = ratio
