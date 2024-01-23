extends ItemContainer

func hit():
	if !opened:
		opened = !opened
		$Lid.hide()
		
		for i in range(3):
			var pos = $Spawners.get_child(i).global_position
			var direction : Vector3 = $Spawners.get_child(i).get_global_transform().basis.z
			
			open.emit(pos, direction)
		
		
		
