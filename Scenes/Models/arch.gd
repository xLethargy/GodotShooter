extends StaticBody3D

signal player_entered_gate

func _ready():
	print ("on scene")

func _on_area_3d_body_entered(body):
	player_entered_gate.emit()
		
func tester():
	print ("hi")
