extends StaticBody3D

signal player_entered_gate

func _on_area_3d_body_entered(body):
	if (body.is_in_group("Player")):
		player_entered_gate.emit()
