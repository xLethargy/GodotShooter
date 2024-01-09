extends Camera3D

@onready var frog : Node3D = %Frog

func _process(_delta):
	var new_position = frog.position
	new_position.y = 5.75
	new_position.z += 1.5
	position = new_position
