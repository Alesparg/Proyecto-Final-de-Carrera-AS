extends Node2D

## Mapa jugable del nivel 5 con diseño de rotonda ovalada.
## Sin barreras ni casas por ahora.

const MAP_WIDTH_TILES := 32
const MAP_HEIGHT_TILES := 20

@onready var tile_layer: TileMapLayer = $TileLayer0


func _ready() -> void:
	print("Level5._ready() iniciado")
	_build_level()
	print("Level5._ready() completado")


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
	print("_build_level() completado")