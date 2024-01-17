extends Area3D

var available_options = ['laser', 'grenade', 'health']
var type = available_options[randi()%len(available_options)]
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


func _on_body_entered(body):
	if type == 'health' and Global.health == 100:
		return
	
	body.add_item(type)
	queue_free()
