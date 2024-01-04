extends Camera3D

func _process(_delta):
	var new_position = $"../Frog".position
	new_position.y = 5.75
	new_position.z += 1
	position = new_position
