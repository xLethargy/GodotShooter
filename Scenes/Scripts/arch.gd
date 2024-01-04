extends StaticBody3D

signal player_entered_gate

func _on_area_3d_body_entered(_body):
	player_entered_gate.emit()
