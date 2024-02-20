extends EnemyParent

var direction

var can_attack : bool = false

signal laser(pos, dir)

func _process(_delta):
	if (player_nearby):
		look_at(Global.player_position)
		
		if !player_attack_nearby:
			position = position.move_toward(Global.player_position, _delta * 2)
			move_and_slide()
	
	if (player_attack_nearby and can_attack and !aiming):
		_weapon_process()


func _weapon_process():
	print ("attacking")
	$AttackAnimation.play("attack")
	can_attack = false
	%WeaponCooldown.start()
	
	Global.health -= 1


func _on_weapon_cooldown_timeout():
	print ("weapon cooldown over")
	can_attack = true


func _on_attack_area_body_entered(_body):
	if !aiming:
		aiming = true
		%AimTimer.start()
	player_attack_nearby = true


func _on_attack_area_body_exited(_body):
	player_attack_nearby = false
	aiming = false
	if current_ammo_count < max_ammo_count and !reloading and current_health > 0:
		can_attack = false
		reloading = true
		%ReloadCooldown.start()

func _on_aim_timer_timeout():
	print ("aiming cooldown over")
	can_attack = true
	aiming = false


func _on_vision_area_body_entered(_body):
	player_nearby = true


func _on_vision_area_body_exited(_body):
	player_nearby = false
