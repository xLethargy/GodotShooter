extends LevelParent

func _on_arch_area_body_entered(body):
	var tween : Tween = create_tween()
	tween.tween_property(player, "current_speed", 0, 0.5)
