extends Node3D


func _ready():
	$RedExplosion.emitting = true
	$YellowExplosion.emitting = true
	$OrangeExplosion.emitting = true


func _on_red_explosion_finished():
	queue_free()
