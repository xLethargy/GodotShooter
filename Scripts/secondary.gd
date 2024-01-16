extends RigidBody3D

signal grenade_velocity

@export var vertical_lob_power: float = 4.0

@onready var level_node = get_tree().current_scene

@onready var material = $MeshInstance3D.get_active_material(0)
@onready var tick_count : int = 0

var flicker_bool = false

func _ready():
	var direction_facing: Vector3 = get_global_transform().basis.z
	var lob_velocity: float = level_node.screen_point_to_ray("grenade")
	
	linear_velocity = direction_facing * lob_velocity
	linear_velocity.y += lob_velocity / 2
	

func _process(_delta):
	on_animation_play()

func _on_explosion_timer_timeout():
	$RedExplosion.emitting = true
	$YellowExplosion.emitting = true
	$OrangeExplosion.emitting = true
	$MeshInstance3D.queue_free()
	

func _on_player_collision_timer_timeout():
	set_collision_mask_value(3, true)


func _on_orange_explosion_finished():
	queue_free()

func on_animation_play():

	if (!$LightFlicker.visible and flicker_bool == false):
		material.emission_enabled = false
		flicker_bool = true
	elif ($LightFlicker.visible and flicker_bool == true):
		material.emission_enabled = true
		tick_count += 1
		flicker_bool = false
		if tick_count == 3:
			material.emission = Color("b53321")
			$LightFlicker.light_color = Color("b53321")
