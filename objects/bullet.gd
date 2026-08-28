extends Area2D

@export var speed: float = 560.0
@export var life_time: float = 1.2

var direction: Vector2 = Vector2.RIGHT
var _life_left: float = 0.0

func _ready() -> void:
	_life_left = life_time
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
	if direction.length() > 0:
		global_position += direction.normalized() * speed * delta
	_life_left -= delta
	if _life_left <= 0.0:
		queue_free()

func _on_body_entered(_body: Node) -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage()
	queue_free()
