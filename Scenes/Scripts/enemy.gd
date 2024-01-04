extends Node

var max_health : int = 5
var current_health : int

var current_position : Vector3 #TESTING

func _ready():
	current_health = max_health
	current_position = self.position

func hit():
	print (current_health)
	current_health -= 1
	if current_health == 0:
		self.position = Vector3(100, 100, 100)
		$RespawnTestTimer.start()

# TESTING
func _on_respawn_test_timer_timeout():
	self.position = current_position
	current_health = max_health
