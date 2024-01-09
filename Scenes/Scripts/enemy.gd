extends Node

var max_health : int = 5
var current_health : int = max_health



func hit():
	current_health -= 1
	if current_health == 0:
		$Hitbox.set_deferred("disabled", true)
		self.visible = false
		$RespawnTestTimer.start()

# TESTING
func _on_respawn_test_timer_timeout():
	self.visible = true
	$Hitbox.set_deferred("disabled", false)
	current_health = max_health
