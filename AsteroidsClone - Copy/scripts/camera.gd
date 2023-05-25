extends Camera2D

var t = 0
var frequency = 50
var magnitude = 0
var x_start = 0
var y_start = 0

func _process(delta):
	t += delta
	magnitude = lerp(magnitude, 0, delta * 10)
	offset_h = sin(t * frequency + x_start) * magnitude
	offset_v = sin(t * frequency + y_start) * magnitude
	
func shake():
	randomize()
	x_start = rand_range(0, 2*PI)
	y_start = rand_range(0, 2*PI)
	magnitude = 1
