extends RigidBody3D

@export var lob_power: float = 10.0
@export var vertical_lob_power: float = 4.0

func _ready():
	var direction_facing: Vector3 = get_global_transform().basis.z
	
	linear_velocity = direction_facing * lob_power
	linear_velocity.y += vertical_lob_power



func _on_explosion_timer_timeout():
	$RedExplosion2.emitting = true
	$YellowExplosion.emitting = true
	$OrangeExplosion.emitting = true
