extends Control

@onready var label = $Label
var single_player_score
var player1_score
var player2_score
var is_single_game
# Called when the node enters the scene tree for the first time.
func _ready():
	single_player_score = Scores.single_player_score
	player1_score = Scores.player1_score
	player2_score = Scores.player2_score
	is_single_game = Scores.is_single_game

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_single_game:
		label.text = "Game Over\nScore = " + str(single_player_score)
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
