extends Area2D

signal player_reached_goal(player: Node)

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_reached_goal.emit(body)
