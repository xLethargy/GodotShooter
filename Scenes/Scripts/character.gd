extends CharacterBody3D

signal primary_fire(pos, rot)
signal secondary_fire(pos, rot)

var can_primary: bool = true
var can_secondary: bool = true

var shooter_marker

var speed: float = 7.0
var rotation_speed: float = 12.0

func _ready():
	shooter_marker = $FrogPointer

func _process(delta):
	_character_movement(delta)
	_shoot_commands()

func _character_movement(_delta):
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
		
		#self.rotation.y = lerp_angle(self.rotation.y, atan2( direction.x , direction.z), delta * rotation_speed)
	
	velocity = direction * speed
	
	look_at(_screen_point_to_ray(), Vector3.UP)
	global_rotation.x = 0
	move_and_slide()

func _shoot_commands():
	if Input.is_action_pressed("primary") and can_primary:
		primary_fire.emit(shooter_marker.global_position, shooter_marker.global_rotation)
		can_primary = false
		$PrimaryTimer.start()
	
	if Input.is_action_just_pressed("secondary") and can_secondary:
		secondary_fire.emit(shooter_marker.global_position, shooter_marker.global_rotation)
		can_secondary = false
		$SecondaryTimer.start()

func _on_primary_timer_timeout():
	can_primary = true


func _on_secondary_timer_timeout():
	can_secondary = true

func _screen_point_to_ray():
	var space_state = get_world_3d().direct_space_state
	
	var mouse_position = get_viewport().get_mouse_position() #finds mouse location
	var camera = get_tree().root.get_camera_3d() #grabs camera node
	var ray_origin = camera.project_ray_origin(mouse_position) #where the raycast starts
	var ray_end = ray_origin + camera.project_ray_normal(mouse_position) * 2000 #where the raycast hits and ends
	var ray_result = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(ray_origin, ray_end)) # the data of the raycast hitting the point
	
	var ray_position = ray_result.get("position", Vector3(0, 0, 0)) # grabbing the position field from the ray_result
	
	if ray_position.y != 0:
		return ray_position
	else:
		return Vector3()


