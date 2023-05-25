extends Asteroid

signal rock_killed

func _on_rock_area_entered(area):
	if area is Bullet:		
		queue_free()
		area.queue_free()
		emit_signal("rock_killed")
	
