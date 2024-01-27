extends CharacterBody3D

var max_health : int = 5
var current_health : int = max_health

var player_nearby : bool = false
var can_laser : bool = true
var weapon_choice : int = 1
var laser_position : Vector3
var laser_rotation : Vector3
var shots_fired : int = 0

signal laser(pos, dir)

func _process(_delta):
	if current_health == 1:
		$WeaponCooldown.wait_time = 0.2
		$ReloadCooldown.wait_time = 2.5
	
	if (player_nearby and current_health > 0):
		look_at(Global.player_position)
		if can_laser:
			weapon_choice = (weapon_choice % 2) + 1
			if weapon_choice == 1:
				laser_position = $WeaponPositions/Gun1.global_position
				laser_rotation = $WeaponPositions/Gun1.global_rotation
			elif weapon_choice == 2:
				laser_position = $WeaponPositions/Gun2.global_position
				laser_rotation = $WeaponPositions/Gun2.global_rotation
			laser.emit(laser_position, laser_rotation)
			shots_fired += 1
			can_laser = false
			
			if shots_fired < 6:
				$WeaponCooldown.start()
			else:
				$ReloadCooldown.start()

func hit():
	current_health -= 1
	if current_health == 0:
		$Hitbox.set_deferred("disabled", true)
		self.visible = false
		
		if %RespawnTestTimer != null:
			%RespawnTestTimer.start()

# TESTING
func _on_respawn_test_timer_timeout():
	self.visible = true
	$Hitbox.set_deferred("disabled", false)
	current_health = max_health


func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_weapon_cooldown_timeout():
	can_laser = true


func _on_reload_cooldown_timeout():
	can_laser = true
	shots_fired = 0
