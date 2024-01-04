extends RigidBody3D

@export var speed: float = 50

func _process(_delta):
	var direction_facing: Vector3 = get_global_transform().basis.z
	#position += direction_facing * speed * delta #THIS WAS BEFORE PRIMARY WAS RIGIDBODY
	
	linear_velocity = direction_facing * 50

func _on_destroy_timer_timeout():
	queue_free()


func _on_collision_detector_body_entered(body):
	if "hit" in body:
		body.hit()
		queue_free()
	
	queue_free()
