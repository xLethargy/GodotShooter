extends CharacterBody3D
class_name EnemyParent

@export var max_ammo_count : int = 6
var current_ammo_count : int = max_ammo_count

@export var max_health : int = 5
var current_health : int = max_health

var player_nearby : bool = false
var player_attack_nearby : bool = false

var reloading : bool = false
var aiming : bool = false

func hit(damage):
	current_health -= damage
	if current_health <= 0:
		queue_free()
