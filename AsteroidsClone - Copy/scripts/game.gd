extends Node

#Game script. Spawn in a number of asteroids at start

export var num_asteroids = 1
var num_asteroids_left = 0
var score = 0
onready var asteroid = preload("res://scenes/asteroid.tscn")
onready var bullet = preload("res://scenes/bullet.tscn")
onready var rock = preload("res://scenes/rock.tscn")

func _ready():
	spawn_wave()
	
func spawn_wave():
	#spawn a number of asteroids
	for i in num_asteroids:		
		var new_asteroid = asteroid.instance()
		new_asteroid.position = get_random_position()
		new_asteroid.connect("asteroid_destroyed", self, "_on_asteroid_destroyed")
		num_asteroids_left += 1
		add_child(new_asteroid)
	
func get_random_position():
	#return a random screen position
	randomize() #To give a different seed each time
	var x = rand_range(0, 1024)
	var y = rand_range(0, 600)
	var v = Vector2(x, y)
	return v
	
func _process(_delta):
	if Input.is_action_just_pressed("fire"):
		var new_bullet = bullet.instance()
		new_bullet.position = $player.position
		new_bullet.rotation = $player.rotation
		add_child(new_bullet)

func _on_asteroid_destroyed(pos):
	$camera.shake()
	score += 50
	$canvas_layer/label_score.text = "Score: " + str(score).pad_zeros(4)
	num_asteroids_left -= 1 
	for i in range(3):
		var new_rock = rock.instance()
		new_rock.position = pos
		add_child(new_rock)
		new_rock.connect("rock_killed", self, "_on_rock_killed")
		num_asteroids_left += 1
	

	#print("asteroid destroyed, this is where you'd add the sound")


func _on_player_killed():
	$restart.start()
	
func _on_rock_killed():
	$camera.shake()
	score += 20
	num_asteroids_left -= 1
	$canvas_layer/label_score.text = "Score: " + str(score).pad_zeros(4)
	if num_asteroids_left <= 0:
		num_asteroids += 2
		spawn_wave()

func _on_restart_timeout():
	get_tree().change_scene("res://scenes/menu.tscn")
	pass # Replace with function body.
