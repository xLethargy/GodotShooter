extends Node3D
class_name LevelParent

@onready var player : Node3D = %Frog

var laser_scene : PackedScene = preload("res://Scenes/Projectiles/primary.tscn")
var enemy_laser_scene : PackedScene = preload("res://Scenes/Projectiles/enemy_primary.tscn")
var grenade_scene : PackedScene = preload("res://Scenes/Projectiles/secondary.tscn")
var item_scene : PackedScene = preload("res://Scenes/Items/item.tscn")

var explosion_scene : PackedScene = preload("res://Scenes/Projectiles/explosion.tscn")

func _ready():
	for item_container in get_tree().get_nodes_in_group("Container"):
		item_container.connect("open", _on_container_opened)
	for sheriff in get_tree().get_nodes_in_group("Sheriff"):
		sheriff.connect("laser", _on_sheriff_shoot)
	for explosion in get_tree().get_nodes_in_group("Explosion"):
		explosion.connect("explosion", _on_grenade_explosion)
	
	


func _on_container_opened(pos, dir):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = dir
	
	$Items.add_child(item)


func _on_frog_primary_fire(laser_position, laser_rotation):
	create_laser(laser_position, laser_rotation, laser_scene)



func _on_frog_secondary_fire(grenade_position, grenade_rotation):
	var grenade = grenade_scene.instantiate() as RigidBody3D
	grenade.position = grenade_position
	grenade.rotation = grenade_rotation
	$Projectiles.add_child(grenade)
	grenade.connect("explosion", _on_grenade_explosion)


func _on_grenade_explosion(explosion_position, explosion_rotation, explosion_radius):
	var explosion = explosion_scene.instantiate()
	explosion.position = explosion_position
	explosion.rotation = explosion_rotation
	$Projectiles.add_child(explosion)
	
	var targets = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
	for target in targets:
		var distance = explosion_position.distance_to(target.global_position)
		
		if distance <= explosion_radius:
			var extra_damage = 0
			if distance < 2:
				extra_damage = 2
			
			target.hit((explosion_radius - distance) + extra_damage)
			


func _on_sheriff_shoot(laser_position, laser_rotation):
	create_laser(laser_position, laser_rotation, enemy_laser_scene)


func create_laser(laser_position, laser_rotation, given_laser_scene):
	var laser = given_laser_scene.instantiate()
	laser.position = laser_position
	laser.rotation = laser_rotation
	$Projectiles.add_child(laser)

func screen_point_to_ray(scene_calling : String):
	var space_state = get_world_3d().direct_space_state
	
	var mouse_position = get_viewport().get_mouse_position() #finds mouse location
	var camera =  %MainCamera#grabs camera node
	
	var ray_length = 2000 # length of raycast
	var ray_origin = camera.project_ray_origin(mouse_position) #where the raycast starts
	var ray_end = ray_origin + camera.project_ray_normal(mouse_position) * ray_length #where the raycast hits and ends
	var ray_result = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(ray_origin, ray_end, 1)) # the data of the raycast hitting the point
	
	var ray_position = ray_result.get("position", Vector3(0, 0, 0)) # grabbing the position field from the ray_result
	
	
	if (scene_calling == "player"):
		if ray_position.y != 0:
			return ray_position
		else:
			return Vector3()
	
	if (scene_calling == "grenade"):
		var lob_velocity : float = (abs(%Frog.position.z - ray_position.z) + abs(%Frog.position.x - ray_position.x))
		if (lob_velocity > 17):
			lob_velocity = 17
		elif (lob_velocity < 1):
			lob_velocity = 1
		
		return lob_velocity

