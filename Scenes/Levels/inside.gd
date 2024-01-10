extends LevelParent


func _on_gate_area_body_entered(_body):
	var tween : Tween = create_tween()
	tween.tween_property(player, "current_speed", 0, 0.5)
	
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/Levels/outside.tscn")
