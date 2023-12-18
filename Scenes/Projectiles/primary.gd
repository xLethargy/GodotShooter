extends Area3D

@export var speed: float = 50

func _process(delta):
	var direction_facing: Vector3 = get_global_transform().basis.z
	position += direction_facing * speed * delta
