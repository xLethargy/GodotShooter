extends GridMap

const barrel = preload("res://Scenes/Models/barrel.tscn")
const crate = preload("res://Scenes/Models/crate.tscn")
const campfire = preload("res://Scenes/Models/campfire.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var barrels = get_used_cells_by_item(0)
	var crates = get_used_cells_by_item(1)
	var campfires = get_used_cells_by_item(2)
	
	tile_replacer(crates, crate)
	tile_replacer(barrels, barrel)
	tile_replacer(campfires, campfire)

func tile_replacer(cell_arr : Array, instance):
	var cell_pos = Vector3()
	for i in cell_arr:
		var new_object = new_object(i, cell_pos, instance)
	
func new_object(cell : Vector3, cell_pos : Vector3, instance):
	var new_instance = instance.instantiate()
	cell_pos = map_to_local(cell)
	new_instance.position = cell_pos
	set_cell_item(cell, -1)
	add_child(new_instance)
	
