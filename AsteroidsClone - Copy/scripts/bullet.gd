extends Area2D
class_name Bullet

export var speed = 500

func _process(delta):
	position += transform.x * speed * delta
	pass
	


func _on_Timer_timeout():
	 queue_free()
