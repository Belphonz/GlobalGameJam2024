extends TileMap

func _ready():
	pass

func _input(event):
	var works: bool = false
	#Creates Tile on click, this will only work if "works" is true to allow for testing
	if Input.is_action_just_pressed("Click") && works == true:
		var mouse_pos : Vector2 = get_global_mouse_position()
		create_bounce_tile(mouse_pos)
		

func create_bounce_tile(mouse_pos):
	var tile_mouse_pos : Vector2i = self.local_to_map(mouse_pos)
	
	var atlas_coord_bounce : Vector2i = Vector2i(1,1)
	
	var tile_data : TileData = self.get_cell_tile_data(0, tile_mouse_pos, false)
	
	self.set_cell(0, tile_mouse_pos, 1, atlas_coord_bounce)
