extends Area2D

signal slot_clicked(slot: Area2D)

var turret: Node2D = null
var slot_index: int = 0

func _ready() -> void:
	input_pickable = true
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func is_occupied() -> bool:
	return turret != null and is_instance_valid(turret)

func place_turret(turret_scene: PackedScene) -> Node2D:
	if is_occupied():
		return turret

	var new_turret := turret_scene.instantiate()
	var world := get_tree().current_scene
	world.get_node("Turrets").add_child(new_turret)
	new_turret.global_position = global_position
	turret = new_turret
	$Highlight.visible = false
	$EmptyIndicator.visible = false
	return new_turret

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		slot_clicked.emit(self)

func _on_mouse_entered() -> void:
	if not is_occupied():
		$Highlight.visible = true

func _on_mouse_exited() -> void:
	$Highlight.visible = false
