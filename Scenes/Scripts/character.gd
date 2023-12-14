extends CharacterBody3D


var speed: float = 7.0
var rotation_speed: float = 12.0

func _process(delta):
	_character_movement(delta)
	_shoot_commands()

func _character_movement(delta):
	var direction: Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	
	if Input.is_action_pressed("up"):
		direction.z -= 1
	if Input.is_action_pressed("down"):
		direction.z += 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
		$FrogMeshes.rotation.y = lerp_angle($FrogMeshes.rotation.y, atan2( -direction.z , direction.x), delta * rotation_speed)
	
	velocity = direction * speed
	
	move_and_slide()

func _shoot_commands():
	if Input.is_action_just_pressed("primary"):
		print("shoot primary")
	if Input.is_action_just_pressed("secondary"):
		print("shoot secondary")
