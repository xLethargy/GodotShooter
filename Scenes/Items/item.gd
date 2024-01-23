extends Area3D

var available_options = ['laser', 'grenade', 'health']
var type : String = available_options[randi()%len(available_options)]
@onready var material = $MeshInstance3D.get_active_material(0)

func _ready():
	if type == 'laser':
		$OmniLight3D.light_color = Color(0, 0, 1)
		material.emission = Color(0, 0, 1)
	elif type == 'grenade':
		$OmniLight3D.light_color = Color(1, 0, 0)
		material.emission = Color(1, 0, 0)
	elif type == 'health':
		$OmniLight3D.light_color = Color(0, 1, 0)
		material.emission = Color(0, 1, 0)


func _on_body_entered(_body):
	if type == 'health' and Global.health == 100:
		return
	
	add_item()
	queue_free()

func add_item():
	if type == 'laser':
		Global.laser_amount += 5
	elif type == 'grenade':
		Global.grenade_amount += 2
	elif type == 'health':
		Global.health += 25
