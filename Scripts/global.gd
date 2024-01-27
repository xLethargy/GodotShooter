extends Node

signal stat_change

var laser_amount = 16:
	set(value):
		laser_amount = value
		stat_change.emit()

var grenade_amount = 3:
	set(value):
		grenade_amount = value
		stat_change.emit()

var player_vulnerable : bool = true

var health = 10:
	set(value):
		health = min(value, 10)
		stat_change.emit()

var player_position : Vector3
