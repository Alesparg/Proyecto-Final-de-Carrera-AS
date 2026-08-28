extends Area2D

@export var move_offset: Vector2 = Vector2(220.0, 0.0)
@export var move_duration: float = 1.8

var _start_position: Vector2
var _end_position: Vector2
var _to_end: bool = true

func _ready() -> void:
	_start_position = global_position
	_end_position = _start_position + move_offset
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	var target := _end_position if _to_end else _start_position
	var step := (delta / maxf(move_duration, 0.01))
	global_position = global_position.lerp(target, step)

	if global_position.distance_to(target) < 2.0:
		_to_end = not _to_end

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and body.has_method("explode"):
		body.explode()
