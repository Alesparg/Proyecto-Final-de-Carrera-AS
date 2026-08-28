extends RigidBody2D

@export var linear_damping: float = 6.0

func _ready() -> void:
	add_to_group("push_box")
	gravity_scale = 1.0   # 👈 IMPORTANTE (tiene peso)
	lock_rotation = true  # 👈 evita que giren tipo caja loca
	linear_damp = linear_damping
