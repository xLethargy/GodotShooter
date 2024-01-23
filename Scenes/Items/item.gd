extends Area3D

var available_options = ['laser', 'grenade', 'health']
var type : String = available_options[randi()%len(available_options)]

@onready var material = $MeshInstance3D.get_active_material(0)

var direction : Vector3
var distance : float = 1.5

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
		
	# tween
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.25)
	tween.tween_property(self, "scale", Vector3(1, 1, 1), 0.25).from(Vector3(0, 0, 0))


func _on_body_entered(_body):
	if type == 'health' and Global.health >= 100:
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
