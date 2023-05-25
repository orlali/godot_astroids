extends Area2D

export var rotate_speed = 5
var velocity = Vector2.ZERO
var thrust = 0
signal player_killed

func _process(delta):
	#Get input and rotate
	var rot = Input.get_axis("left", "right") * rotate_speed
	rotate(rot * delta)
	thrust = Input.get_action_strength("thrust")
	velocity += transform.x * thrust * 20
	velocity = lerp(velocity, Vector2.ZERO, 1 * delta)
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
	



func _on_player_area_entered(area):
	#restart the game if an asteroid (not bullet) hits you
	if !area is Bullet:
		emit_signal("player_killed")
		queue_free()
	
	
