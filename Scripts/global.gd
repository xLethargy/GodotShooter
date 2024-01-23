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

var health = 70:
	set(value):
		health = value
		stat_change.emit()
