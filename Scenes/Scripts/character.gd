extends CharacterBody3D

signal primary_fire
signal secondary_fire

var can_primary: bool = true
var can_secondary: bool = true

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
	if Input.is_action_just_pressed("primary") and can_primary:
		primary_fire.emit()
		can_primary = false
		$PrimaryTimer.start()
	
	if Input.is_action_just_pressed("secondary") and can_secondary:
		secondary_fire.emit()
		can_secondary = false
		$SecondaryTimer.start()

func _on_primary_timer_timeout():
	can_primary = true


func _on_secondary_timer_timeout():
	can_secondary = true
