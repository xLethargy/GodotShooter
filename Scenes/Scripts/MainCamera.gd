extends Camera3D

@onready var frog : Node3D = %Frog
@onready var camera_position : Vector3 = self.position

func _process(_delta):
	var new_position = frog.position
	new_position.y = camera_position.y
	new_position.z += 1.5
	position = new_position
