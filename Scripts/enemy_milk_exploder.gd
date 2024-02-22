extends EnemyParent

var explosion_radius : int = 7

signal explosion(position, rotation, radius)

func _process(_delta):
	if (player_nearby):
		look_at(Global.player_position)
		
		if !player_attack_nearby:
			position = position.move_toward(Global.player_position, _delta * speed)
			move_and_slide()
	
	if (player_attack_nearby and can_attack and !aiming):
		_weapon_process()


func _weapon_process():
	#$AttackAnimation.play("attack")
	can_attack = false

	explosion.emit(position, global_rotation, explosion_radius)
	queue_free()
	

func _on_attack_area_body_entered(_body):
	if !aiming:
		aiming = true
		%AimTimer.start()
	player_attack_nearby = true

func _on_aim_timer_timeout():
	can_attack = true
	aiming = false


func _on_vision_area_body_entered(_body):
	player_nearby = true


func _on_vision_area_body_exited(_body):
	player_nearby = false
