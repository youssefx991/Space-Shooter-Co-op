extends Node2D

@onready var player1_spawn_position = $player1_spawn_position


var player1 = null
# Called when the node enters the scene tree for the first time.
func _ready():
	player1 = get_tree().get_first_node_in_group('player')
	assert(player1 != null)
	player1.global_position = player1_spawn_position.global_position	
	player1.laser_shot.connect(_on_player1_laser_shot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()


func _on_player1_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	add_child(laser)


func _on_enemy_say_entered_land(location):
	if location.x < $split_screen_position.global_position.x:
		player1.damage()
