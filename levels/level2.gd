extends Node2D

## Mapa jugable con bordes y barreras visibles específicas del nivel 2.

const MAP_WIDTH_TILES := 32
const MAP_HEIGHT_TILES := 20

@onready var tile_layer: TileMapLayer = $TileLayer0
var obstacle_texture: Texture2D


func _ready() -> void:
	print("Level2._ready() iniciado")
	obstacle_texture = preload("res://objects/obstacle.png")
	_build_level()
	print("Level2._ready() completado")


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
	
	# Añadir barreras visuales específicas del nivel 2
	_build_level2_barriers()
	print("_build_level() completado")


func _build_level2_barriers() -> void:
	print("_build_level2_barriers() iniciado")
	
	# El nivel está desplazado por (1496, 404) en colworld.tscn
	var level_offset_x = -1496
	var level_offset_y = -404
	
	# ============================================================
	# BARRERAS ESPECÍFICAS DEL NIVEL 2
	# Basadas directamente en las posiciones marcadas en rojo
	# ============================================================
	
	# ------------------------------------------------------------
	# PARTE IZQUIERDA
	# ------------------------------------------------------------
	
	# Barrera horizontal pequeña arriba a la izquierda
	_create_barrier_rect(
		32 + level_offset_x,
		198 + level_offset_y,
		64,
		32
	)
	
	# Barrera vertical arriba a la izquierda
	_create_barrier_rect(
		126 + level_offset_x,
		46 + level_offset_y,
		32,
		128
	)
	
	# Barrera horizontal izquierda de la zona media
	_create_barrier_rect(
		32 + level_offset_x,
		408 + level_offset_y,
		64,
		32
	)
	
	# Barrera horizontal que va hacia el centro
	_create_barrier_rect(
		160 + level_offset_x,
		408 + level_offset_y,
		96,
		32
	)
	
	
	# ------------------------------------------------------------
	# PARTE CENTRAL IZQUIERDA
	# ------------------------------------------------------------
	
	# Barrera vertical central superior
	_create_barrier_rect(
		568 + level_offset_x,
		76 + level_offset_y,
		32,
		128
	)
	
	# Barrera vertical central inferior
	_create_barrier_rect(
		308 + level_offset_x,
		256 + level_offset_y,
		32,
		128
	)
	
	
	# ------------------------------------------------------------
	# PARTE CENTRAL / DERECHA
	# ------------------------------------------------------------
	
	# Barrera vertical central derecha
	_create_barrier_rect(
		799 + level_offset_x,
		250 + level_offset_y,
		32,
		128
	)
	
	# Barrera vertical central derecha inferior
	_create_barrier_rect(
		554 + level_offset_x,
		256 + level_offset_y,
		32,
		128
	)
	
	# Gran barrera horizontal inferior
	_create_barrier_rect(
		448 + level_offset_x,
		562 + level_offset_y,
		456,
		32
	)
	
	# Barrera vertical del extremo derecho
	_create_barrier_rect(
		806 + level_offset_x,
		456 + level_offset_y,
		32,
		130
	)
	
	
	# ============================================================
	# CASAS / OBSTÁCULOS
	# Posiciones marcadas en rojo en la parte inferior
	# ============================================================
	
	# ------------------------------------------------------------
	# GRUPO DE CASAS IZQUIERDO
	# ------------------------------------------------------------
	
	_create_barrier_sprite(
		160 + level_offset_x,
		680 + level_offset_y
	)
	
	
	# ------------------------------------------------------------
	# GRUPO DE CASAS CENTRAL
	# ------------------------------------------------------------
	
	_create_barrier_sprite(
		448 + level_offset_x,
		680 + level_offset_y
	)
	
	
	# ------------------------------------------------------------
	# GRUPO DE CASAS DERECHO
	# ------------------------------------------------------------
	
	_create_barrier_sprite(
		800 + level_offset_x,
		680 + level_offset_y
	)
	
	
	print("Barreras del nivel 2 creadas")
	print("Casas/obstáculos del nivel 2 creadas")
	print("_build_level2_barriers() completado")


func _create_barrier_rect(x: int, y: int, width: int, height: int) -> void:
	var color_rect = ColorRect.new()
	color_rect.position = Vector2(x, y)
	color_rect.size = Vector2(width, height)
	color_rect.color = Color(0.4, 0.3, 0.5, 0.8)
	color_rect.z_index = 5
	add_child(color_rect)
	print("Barrera nivel 2 creada en: ", x, ", ", y)


func _create_barrier_sprite(x: int, y: int) -> void:
	var sprite = Sprite2D.new()
	sprite.texture = obstacle_texture
	sprite.position = Vector2(x, y)
	sprite.scale = Vector2(1.5, 1.5)
	sprite.modulate = Color(0.7, 0.6, 0.8, 1.0)
	sprite.z_index = 6
	add_child(sprite)
	print("Sprite nivel 2 creado en: ", x, ", ", y)
