extends GridMap

const barrel = preload("res://Scenes/Models/barrel.tscn")
const crate = preload("res://Scenes/Models/crate.tscn")
const campfire = preload("res://Scenes/Models/campfire.tscn")
const flag = preload("res://Scenes/Models/flag.tscn")
const light_holder = preload("res://Scenes/Models/light_holder.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var barrels = get_used_cells_by_item(0)
	var crates = get_used_cells_by_item(1)
	var campfires = get_used_cells_by_item(2)
	var flags = get_used_cells_by_item(3)
	var light_holders = get_used_cells_by_item(4)
	
	tile_replacer(crates, crate)
	tile_replacer(barrels, barrel)
	tile_replacer(campfires, campfire)
	tile_replacer(flags, flag)
	tile_replacer(light_holders, light_holder)

func tile_replacer(cells : Array, instance : PackedScene):
	for i in cells:
		new_object(i, instance)
	
func new_object(cell : Vector3, instance : PackedScene):
	var new_instance = instance.instantiate()
	var cell_pos = map_to_local(cell)
	new_instance.position = cell_pos
	
	set_cell_item(cell, -1)
	add_child(new_instance)
	
