extends RigidBody3D

@export var is_enemy : bool = false
@export var speed: float = 40

@onready var direction_facing: Vector3 = get_global_transform().basis.z

func _process(_delta):
	
	#position += direction_facing * speed * delta #THIS WAS BEFORE PRIMARY WAS RIGIDBODY
	
	linear_velocity = direction_facing * speed

func _on_destroy_timer_timeout():
	queue_free()


func _on_collision_detector_body_entered(body):
	if "hit" in body:
		if body.is_in_group("Enemy") and is_enemy:
			queue_free()
		else:
			body.hit(1)
	
	queue_free()
