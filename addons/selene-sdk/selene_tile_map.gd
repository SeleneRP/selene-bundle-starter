@tool
extends TileMap
class_name SeleneTileMap

var _tile_sets: Array[TileSet] = []
@export var tile_sets: Array[TileSet]:
	get:
		return _tile_sets
	set(value):
		_tile_sets = value
		_merge_tile_set()

@export var mappings: Dictionary = {}

func _process(delta):
	if not Engine.is_editor_hint():
		return
	if not tile_set:
		tile_set = TileSet.new()
	# TODO would be nice to support other shapes / sizes in the future
	if tile_set.tile_shape != TileSet.TILE_SHAPE_ISOMETRIC:
		tile_set.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
	if tile_set.tile_size != Vector2i(64, 32):
		tile_set.tile_size = Vector2i(64, 32)
	if not y_sort_enabled:
		y_sort_enabled = true
	for i in get_layers_count():
		if not is_layer_y_sort_enabled(i):
			set_layer_y_sort_enabled(i, true)
	
func _merge_tile_set():
	if not tile_set:
		return
	
	mappings = {}
	for i in tile_set.get_source_count():
		var source_id = tile_set.get_source_id(i)
		var source = tile_set.get_source(source_id)
		if not source.resource_name:
			push_error("TileSet source has no resource name")
			continue
		mappings[source.resource_name] = source_id

	for i in range(tile_set.get_source_count(), 0, -1):
		var source_id = tile_set.get_source_id(i - 1)
		tile_set.remove_source(source_id)

	for external_tile_set in _tile_sets:
		if not external_tile_set:
			continue
		
		for i in external_tile_set.get_source_count():
			var external_source_id = external_tile_set.get_source_id(i)
			var external_source = external_tile_set.get_source(external_source_id)
			if not mappings.has(external_source.resource_name):
				mappings[external_source.resource_name] = tile_set.get_next_source_id()
			var copied_source = _copy_tile_set_source(external_source)
			tile_set.add_source(copied_source, mappings[external_source.resource_name])

func _copy_tile_set_source(source: TileSetSource) -> TileSetSource:
	var copy: TileSetSource
	if source is TileSetAtlasSource:
		copy = TileSetAtlasSource.new()
		copy.texture = source.texture
		copy.margins = source.margins
		copy.separation = source.separation
		copy.texture_region_size = source.texture_region_size
		copy.use_texture_padding = source.use_texture_padding
		for i in source.get_tiles_count():
			var coords = source.get_tile_id(i)
			var size = source.get_tile_size_in_atlas(coords)
			var source_tile = source.get_tile_data(coords, 0)
			copy.create_tile(coords, size)
			var copied_tile = copy.get_tile_data(coords, 0)
			_copy_tile_data(source_tile, copied_tile)
			for j in source.get_alternative_tiles_count(coords):
				var alt_id = source.get_alternative_tile_id(coords, j)
				if alt_id == 0:
					continue
				var source_alt_tile = source.get_tile_data(coords, alt_id)
				copy.create_alternative_tile(coords, alt_id)
				var copied_alt_tile = copy.get_tile_data(coords, alt_id)
				_copy_tile_data(source_alt_tile, copied_alt_tile)
	elif source is TileSetScenesCollectionSource:
		copy = TileSetScenesCollectionSource.new()
		for i in source.get_scene_tiles_count():
			var tile_id = source.get_scene_tile_id(i)
			var scene = source.get_scene_tile_tile(i)
			copy.create_scene_tile(scene, tile_id)
			copy.set_scene_tile_display_placeholder(tile_id, source.get_scene_tile_display_placeholder(tile_id))
	copy.resource_name = source.resource_name
	return copy

func _copy_tile_data(source: TileData, target: TileData):
	target.flip_h = source.flip_h
	target.flip_v = source.flip_v
	target.material = source.material
	target.modulate = source.modulate
	target.probability = source.probability
	if source.terrain_set != -1:
		target.terrain_set = source.terrain_set
	if source.terrain != -1:
		target.terrain = source.terrain
	target.texture_origin = source.texture_origin
	target.transpose = source.transpose
	target.y_sort_origin = source.y_sort_origin
	target.z_index = source.z_index