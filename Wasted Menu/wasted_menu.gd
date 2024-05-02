extends Control

@onready var label = $Label
var single_player_score
var player1_score
var player2_score
var is_single_game
var killed_player
# Called when the node enters the scene tree for the first time.
func _ready():
	single_player_score = Scores.single_player_score
	player1_score = Scores.player1_score
	player2_score = Scores.player2_score
	is_single_game = Scores.is_single_game
	killed_player = Scores.killed_player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_single_game:
		label.text = "Game Over\nScore = " + str(single_player_score)
	elif killed_player == 1:
		label.text = "Player 2 killed Player 1"
		label.text += "\nPlayer 2 Wins!"
	elif killed_player == 2:
		label.text = "Player 1 killed Player 2"
		label.text += "\nPlayer 1 Wins!"
	else:
		if player1_score > player2_score:
			label.text = "Player 1 Score = " + str(player1_score)
			label.text += "\nPlayer 2 Score = " + str(player2_score)
			label.text += "\nPlayer 1 Wins!!!"
		elif player1_score > player2_score:
			label.text = "Player 1 Score = " + str(player1_score)
			label.text += "\nPlayer 2 Score = " + str(player2_score)
			label.text += "\nPlayer 2 Wins!!!"
		else:
			label.text = "Player 1 Score = " + str(player1_score)
			label.text += "\nPlayer 2 Score = " + str(player2_score)
			label.text += "\nTIE!!!"


func _on_play_again_pressed():
	if is_single_game:
		get_tree().change_scene_to_file("res://single player world/single_player_world.tscn")
	else:
		get_tree().change_scene_to_file("res://World/world.tscn")


func _on_quit_pressed():
	get_tree().quit()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Main Menu/main_menu.tscn")
