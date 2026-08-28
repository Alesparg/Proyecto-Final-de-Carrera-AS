@tool 
extends CharacterBody2D
class_name Player

@export var MAX_SPEED: float = 220.0
@export var ACCELERATION: float = 400.0
@export var DECELERATION: float = 3800.0
@export var GRAVITY: float = 900.0
@export var JUMP_FORCE: float = -400.0
@export var PUSH_FORCE: float = 220.0
@export var PUSH_MAX_SPEED: float = 85.0

@export var SHOOT_COOLDOWN: float = 0.18
@export var BulletScene: PackedScene

@export var Explosion: PackedScene
var boom

var _shoot_timer: float = 0.0
var _aim_direction: Vector2 = Vector2.RIGHT
var _speed_multiplier: float = 1.0

signal im_dead

func _ready():
	if Engine.is_editor_hint():
		return

	if Explosion != null:
		boom = Explosion.instantiate()

func _physics_process(delta):
	if Engine.is_editor_hint():
		return

	_shoot_timer = maxf(0.0, _shoot_timer - delta)

	# MOVIMIENTO HORIZONTAL
	var input_dir := Input.get_axis("move_left", "move_right")
	var target_velocity_x := input_dir * MAX_SPEED * _speed_multiplier

	if input_dir != 0:
		velocity.x = move_toward(velocity.x, target_velocity_x, ACCELERATION * delta)
		_aim_direction = Vector2(sign(input_dir), 0)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)

	# GRAVEDAD (evita volar)
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	# SALTO
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE

	move_and_slide()
	_push_colliding_boxes(input_dir, delta)

	# EFECTOS VISUALES
	$WalkDust.emitting = is_on_floor() and input_dir != 0

	if input_dir < 0:
		$sprite.flip_h = true
		$WalkDust.process_material.direction.x = 1
	elif input_dir > 0:
		$sprite.flip_h = false
		$WalkDust.process_material.direction.x = -1

	$JumpDust.emitting = Input.is_action_just_pressed("jump") and is_on_floor()

	# DISPARO
	if Input.is_action_just_pressed("shoot"):
		_shoot()

func _push_colliding_boxes(input_dir: float, delta: float) -> void:
	var push_dir: float = float(sign(input_dir))
	if push_dir == 0:
		push_dir = float(sign(velocity.x))
	if push_dir == 0:
		return

	for i in range(get_slide_collision_count()):
		var collision := get_slide_collision(i)
		var body := collision.get_collider() as RigidBody2D
		if body != null and body.is_in_group("push_box"):
			# Solo empuja si la caja esta en frente del jugador.
			var pushing_right := push_dir > 0.0 and collision.get_normal().x < -0.1
			var pushing_left := push_dir < 0.0 and collision.get_normal().x > 0.1
			if not (pushing_right or pushing_left):
				continue

			# Empuje continuo y limitado para evitar que salga disparada.
			if absf(body.linear_velocity.x) < PUSH_MAX_SPEED:
				body.apply_central_force(Vector2(push_dir * PUSH_FORCE, 0.0))

func _shoot() -> void:
	if _shoot_timer > 0.0:
		return
	if BulletScene == null:
		return

	var bullet := BulletScene.instantiate()
	if bullet == null:
		return

	bullet.set("direction", _aim_direction)

	if bullet is Node2D:
		bullet.global_position = global_position + _aim_direction * 22.0
		get_tree().current_scene.add_child(bullet)

	_shoot_timer = SHOOT_COOLDOWN

func explode():
	if is_queued_for_deletion():
		return

	if boom is Node2D:
		boom.position = global_position
		get_tree().current_scene.add_child(boom)

	im_dead.emit()
	queue_free()

func set_speed_multiplier(multiplier: float) -> void:
	_speed_multiplier = maxf(0.1, multiplier)

func reset_speed_multiplier() -> void:
	_speed_multiplier = 1.0
