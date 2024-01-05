extends RigidBody3D

@export var vertical_lob_power: float = 4.0

@onready var level_node = get_node("../../.")


func _ready():
	var direction_facing: Vector3 = get_global_transform().basis.z
	var lob_velocity: float = level_node.screen_point_to_ray("grenade")
	
	linear_velocity = direction_facing * lob_velocity
	linear_velocity.y += lob_velocity / 2

func _on_explosion_timer_timeout():
	$RedExplosion.emitting = true
	$YellowExplosion.emitting = true
	$OrangeExplosion.emitting = true
	$MeshInstance3D.queue_free()
	

func _on_player_collision_timer_timeout():
	set_collision_mask_value(3, true)


func _on_orange_explosion_finished():
	queue_free()
