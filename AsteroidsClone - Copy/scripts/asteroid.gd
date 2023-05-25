extends Area2D
class_name Asteroid

#So that it's not moving at the beginning
var velocity = Vector2.ZERO
#custom signal
signal asteroid_destroyed

func _ready():
	#makes it move when the scene opens
	randomize() #To give a different seed each time
	var x = rand_range(-100, 100)
	var y = rand_range(-100, 100)
	velocity = Vector2(x, y)
	
func _process(delta):
	position += velocity * delta
	wrap()

func wrap():
	if position.x < 0:
		position.x = 1024
	if position.x > 1024:
		position.x = 0
	if position.y < 0:
		position.y = 600
	if position.y > 600:
		position.y = 0



func _on_asteroid_area_entered(area):
	if area is Bullet:
		emit_signal("asteroid_destroyed", global_position)
		area.queue_free()
		queue_free()
