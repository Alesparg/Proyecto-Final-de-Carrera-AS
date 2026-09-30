extends Node2D

## Mapa jugable con bordes y barreras visibles que guían el camino.

const MAP_WIDTH_TILES := 32
const MAP_HEIGHT_TILES := 20

@onready var tile_layer: TileMapLayer = $TileLayer0
var obstacle_texture: Texture2D


func _ready() -> void:
	print("Level1._ready() iniciado")
	obstacle_texture = preload("res://objects/obstacle.png")
	_build_level()
	print("Level1._ready() completado")


func _build_level() -> void:
	print("_build_level() iniciado")
	tile_layer.clear()
	var source_id := 0
	var atlas := Vector2i(0, 0)

	# Construir bordes exteriores
	for x in range(MAP_WIDTH_TILES):
		tile_layer.set_cell(Vector2i(x, 0), source_id, atlas)
		tile_layer.set_cell(Vector2i(x, MAP_HEIGHT_TILES - 1), source_id, atlas)

	for y in range(1, MAP_HEIGHT_TILES - 1):
		tile_layer.set_cell(Vector2i(0, y), source_id, atlas)
		tile_layer.set_cell(Vector2i(MAP_WIDTH_TILES - 1, y), source_id, atlas)
	
	print("Bordes exteriores construidos")
	
	# Añadir barreras visuales usando sprites
	_build_visual_barriers()
	print("_build_level() completado")


func _build_visual_barriers() -> void:
	print("_build_visual_barriers() iniciado")

	# El nivel está desplazado por (1496, 404) en colworld.tscn
	# Necesitamos ajustar las coordenadas para que las barreras aparezcan
	# en la posición correcta relativa al camino
	var level_offset_x = -1496
	var level_offset_y = -404

	# ============================================================
	# ZONA IZQUIERDA
	# ============================================================

	# Pared vertical del extremo izquierdo
	_create_barrier_rect(
		0 + level_offset_x,      # X ajustado
		96 + level_offset_y,     # Y ajustado
		32,     # Ancho
		760     # Alto
	)

	# Pared horizontal superior izquierda
	_create_barrier_rect(
		32 + level_offset_x,
		80 + level_offset_y,
		480,
		32
	)

	


	# ============================================================
	# ZONA CENTRAL - PARTE IZQUIERDA
	# ============================================================

	# Pared vertical central que marcaste en rojo
	_create_barrier_rect(
		512 + level_offset_x,
		80 + level_offset_y,
		32,
		350
	)

	


	# ============================================================
	# ZONA DERECHA
	# ============================================================

	# Pared horizontal superior derecha
	_create_barrier_rect(
		548 + level_offset_x,
		80 + level_offset_y,
		360,
		32
	)

	# Pared vertical derecha superior
	_create_barrier_rect(
		892 + level_offset_x,
		120 + level_offset_y,
		32,
		150
	)

	# Pared vertical derecha inferior
	_create_barrier_rect(
		880 + level_offset_x,
		360 + level_offset_y,
		32,
		175
	)

	# Pared vertical interior derecha
	_create_barrier_rect(
		680 + level_offset_x,
		360 + level_offset_y,
		32,
		220
	)


	# ============================================================
	# CASAS / OBSTÁCULOS INFERIORES
	# ============================================================
	#
	# Estas son las casas que marcaste con rojo en la parte
	# inferior de la captura.
	#

	# Grupo izquierdo
	_create_barrier_sprite(110 + level_offset_x, 745 + level_offset_y)
	_create_barrier_sprite(180 + level_offset_x, 775 + level_offset_y)

	# Grupo central
	_create_barrier_sprite(400 + level_offset_x, 745 + level_offset_y)
	_create_barrier_sprite(460 + level_offset_x, 775 + level_offset_y)

	# Grupo derecho
	_create_barrier_sprite(685 + level_offset_x, 745 + level_offset_y)
	_create_barrier_sprite(755 + level_offset_x, 775 + level_offset_y)


	print("Barreras rectangulares creadas con offset ajustado")
	print("Casas/obstáculos creados con offset ajustado")
	print("_build_visual_barriers() completado")


func _create_barrier_rect(
	x: int,
	y: int,
	width: int,
	height: int
) -> void:

	var color_rect = ColorRect.new()

	color_rect.position = Vector2(x, y)
	color_rect.size = Vector2(width, height)

	color_rect.color = Color(
		0.3,
		0.4,
		0.5,
		0.8
	)

	color_rect.z_index = 5  # Aumentado para asegurar visibilidad

	add_child(color_rect)
	print("Barrera creada en: ", x, ", ", y, " tamaño: ", width, "x", height)


func _create_barrier_sprite(x: int, y: int) -> void:

	var sprite = Sprite2D.new()

	sprite.texture = obstacle_texture
	sprite.position = Vector2(x, y)

	sprite.scale = Vector2(1.5, 1.5)

	sprite.modulate = Color(
		0.6,
		0.7,
		0.8,
		1.0  # Opacidad completa
	)

	sprite.z_index = 6  # Aumentado para asegurar visibilidad

	add_child(sprite)
	print("Sprite barrera creado en: ", x, ", ", y)
