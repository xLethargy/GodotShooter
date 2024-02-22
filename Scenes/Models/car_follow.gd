extends EnemyParent

@onready var parent_path = get_parent()

@onready var original_laser_scale_y = $amazinggun/RayCast3D/LaserPivot/Laser.mesh.size.y

var collider = null

func _process(delta):
	if %RayCast3D.get_collider() != null:
		collider = %RayCast3D.get_collider()
		var distance_math_sum = %RayCast3D.global_position.distance_to(collider.global_position) / original_laser_scale_y
		$amazinggun/RayCast3D/LaserPivot.scale.y = distance_math_sum
	
	if (get_parent().name == "PathFollow3D"):
		parent_path.progress_ratio += 0.025 * delta
	
	if (player_nearby and can_attack and !aiming):
		_weapon_process()

func _weapon_process():
	var player_position_lowered = Vector3(Global.player_position.x, Global.player_position.y - 0.25, Global.player_position.z)
	%amazinggun.look_at(player_position_lowered)
	
	$AnimationPlayer.play("laser")

func fire():
	Global.health -= 1


func hit(damage):
	current_health -= damage
	if current_health <= 0:
		queue_free()


func _on_attack_area_body_entered(_body):
	if !aiming:
		aiming = true
		%AimTimer.start()
	player_nearby = true


func _on_attack_area_body_exited(_body):
	$AnimationPlayer.stop(false)
	player_nearby = false
	aiming = false


func _on_aim_timer_timeout():
	can_attack = true
	aiming = false
