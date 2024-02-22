extends EnemyParent

var weapon_choice : int = 1
var laser_position : Vector3
var laser_rotation : Vector3

signal laser(pos, dir)

func _process(_delta):
	if current_health == 1:
		max_ammo_count = 12
		%WeaponCooldown.wait_time = 0.15
		%ReloadCooldown.wait_time = 2
		%AimTimer.wait_time = 0.25
		$AttackArea/AttackRadius.shape.radius = 20
	
	if (player_nearby):
		look_at(Global.player_position)
		
		if can_attack and !reloading and !aiming:
			_weapon_process()


func _weapon_process():
	weapon_choice = (weapon_choice % 2) + 1
	if weapon_choice == 1:
		laser_position = $WeaponPositions/Gun1.global_position
		laser_rotation = $WeaponPositions/Gun1.global_rotation
	elif weapon_choice == 2:
		laser_position = $WeaponPositions/Gun2.global_position
		laser_rotation = $WeaponPositions/Gun2.global_rotation
	
	laser.emit(laser_position, laser_rotation)
	current_ammo_count -= 1
	can_attack = false
	
	if current_ammo_count > 0:
		%WeaponCooldown.start()
	elif !reloading:
		reloading = true
		%ReloadCooldown.start()


func _on_weapon_cooldown_timeout():
	can_attack = true

func _on_reload_cooldown_timeout():
	can_attack = true
	reloading = false
	current_ammo_count = max_ammo_count


func _on_attack_area_body_entered(_body):
	if !aiming:
		aiming = true
		%AimTimer.start()
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false
	aiming = false
	if current_ammo_count < max_ammo_count and !reloading and current_health > 0:
		can_attack = false
		reloading = true
		%ReloadCooldown.start()

func _on_aim_timer_timeout():
	can_attack = true
	aiming = false
