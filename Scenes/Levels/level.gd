extends Node3D

var laser_scene: PackedScene = preload("res://Scenes/Projectiles/primary.tscn")

func _on_arch_player_entered_gate():
	print ("entered")


func _on_frog_primary_fire():
	var laser = laser_scene.instantiate()
	laser.position = $Frog.position
	add_child(laser)


func _on_frog_secondary_fire():
	pass # Replace with function body.
