extends Camera3D

func _process(delta):
	var new_position = $"../Frog".position
	new_position.y = 5.75
	new_position.z += 1
	position = new_position
