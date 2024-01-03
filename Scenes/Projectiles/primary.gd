extends Area3D

@export var speed: float = 50

func _process(delta):
	var direction_facing: Vector3 = get_global_transform().basis.z
	position += direction_facing * speed * delta

func _on_body_entered(body):
	if !body.is_in_group("Player"):
		queue_free()
