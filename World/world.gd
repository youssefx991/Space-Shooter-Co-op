extends Node2D
@onready var player1 = $Player1
@onready var player2 = $Player2
@onready var player1_spawn_position = $player1_spawn_position
@export var enemy_scenes : Array[PackedScene] = []

var player1_score = 0
var player2_score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	Scores.is_single_game = false
	assert(player1 != null)
	assert(player2 != null)
	
	player1.global_position = player1_spawn_position.global_position	
	player1.laser_shot.connect(_on_player1_laser_shot)
	player2.laser_shot.connect(_on_player1_laser_shot)
	
	player1.player_dead.connect(_on_player_dead)
	player2.player_dead.connect(_on_player_dead)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()


func _on_player1_laser_shot(laser_scene, location, player_number):
	
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser.player_number = player_number
	laser.enemy_dead.connect(_on_enemy_dead)
	add_child(laser)


func _on_enemy_say_entered_land(location):
	
	if location.x < $split_screen_position.global_position.x:
		if player1 != null:
			player1.damage()
	else:
		if player2 != null:
			player2.damage()


func _on_enemy_spawn_timer_timeout():
	var enemy_to_spawn = enemy_scenes.pick_random().instantiate()
	enemy_to_spawn.say_entered_land.connect(_on_enemy_say_entered_land)
	var random_x = randf_range(0, 1152)
	while (random_x == 576):
		random_x = randf_range(0, 1152)
	enemy_to_spawn.global_position = Vector2(random_x, 50)
	add_child(enemy_to_spawn)
	
func _on_player_dead(number):
	get_tree().change_scene_to_file("res://Wasted Menu/wasted_menu.tscn")

func _on_enemy_dead(number):
	if number == 1:
		player1_score += 1
		Scores.player1_score = player1_score
	else:
		player2_score += 1
		Scores.player2_score = player2_score
