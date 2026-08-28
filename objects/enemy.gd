extends Area2D
signal player_touched(player: Node)

@export var speed: float = 90.0
@export var patrol_distance: float = 120.0
@export var start_moving_right: bool = true

var _start_position: Vector2
var _direction: int = 1

func _ready() -> void:
	_start_position = global_position
	_direction = 1 if start_moving_right else -1
	add_to_group("enemies")
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	global_position.x += _direction * speed * delta

	var distance_from_start := global_position.x - _start_position.x
	if distance_from_start >= patrol_distance:
		global_position.x = _start_position.x + patrol_distance
		_direction = -1
	elif distance_from_start <= -patrol_distance:
		global_position.x = _start_position.x - patrol_distance
		_direction = 1

	if has_node("Sprite2D"):
		$Sprite2D.flip_h = _direction < 0

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_touched.emit(body)

func take_damage() -> void:
	queue_free()
