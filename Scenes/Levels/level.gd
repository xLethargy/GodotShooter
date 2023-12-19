extends Node3D

var laser_scene: PackedScene = preload("res://Scenes/Projectiles/primary.tscn")
var grenade_scene: PackedScene = preload("res://Scenes/Projectiles/secondary.tscn")

func _on_arch_player_entered_gate():
	print ("entered")


func _on_frog_primary_fire(laser_position, laser_rotation):
	var laser = laser_scene.instantiate()
	laser.position = laser_position
	laser.rotation = laser_rotation
	$Projectiles.add_child(laser)


func _on_frog_secondary_fire(grenade_position, grenade_rotation):
	var grenade = grenade_scene.instantiate() as RigidBody3D
	grenade.position = grenade_position
	grenade.rotation = grenade_rotation
	$Projectiles.add_child(grenade)
