extends Area2D

@export var speed_multiplier: float = 0.55

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and body.has_method("set_speed_multiplier"):
		body.set_speed_multiplier(speed_multiplier)

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player") and body.has_method("reset_speed_multiplier"):
		body.reset_speed_multiplier()
