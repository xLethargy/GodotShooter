extends CharacterBody3D

signal primary_fire(pos, rot)
signal secondary_fire(pos, rot)

var can_primary: bool = true
var can_secondary: bool = true

var shoot_spit: bool = false

var shooter_marker

var max_speed : float = 5.0
var current_speed: float = max_speed
#var rotation_speed: float = 12.0

@onready var level_node : Node = get_tree().current_scene

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
	
	velocity = direction * current_speed
	
	look_at(level_node.screen_point_to_ray("player"), Vector3.UP)
	global_rotation.x = 0
	move_and_slide()
	global_position.y = 0.551

func _shoot_commands():
	if Input.is_action_pressed("primary") and can_primary:
		can_primary = false
		_shoot_weapon_from_mouth(primary_fire, $PrimaryTimer)
	
	if Input.is_action_just_pressed("secondary") and can_secondary:
		can_secondary = false
		_shoot_weapon_from_mouth(secondary_fire, $SecondaryTimer)
	
	if Input.is_action_just_released("primary") or Input.is_action_just_released("secondary"):
		shoot_spit = false

func _shoot_weapon_from_mouth(weapon_signal, weapon_timer):
	var weapon_position = shooter_marker.global_position
	var weapon_rotation = shooter_marker.global_rotation
	
	weapon_signal.emit(weapon_position, weapon_rotation)
	weapon_timer.start()
	
	if shoot_spit == false:
			$SpitParticles.emitting = true
			shoot_spit = true

func _on_primary_timer_timeout():
	can_primary = true


func _on_secondary_timer_timeout():
	can_secondary = true
