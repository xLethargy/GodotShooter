extends RigidBody3D

var lob_power: float = 15.0

func _ready():
	var direction_facing: Vector3 = get_global_transform().basis.z
	linear_velocity = direction_facing * lob_power
