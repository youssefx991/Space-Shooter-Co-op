extends Node

var single_player_score
var player1_score
var player2_score
var killed_player
var is_single_game
# Called when the node enters the scene tree for the first time.
func _ready():
	single_player_score = 0
	player1_score = 0
	player2_score = 0
	is_single_game = true
	killed_player = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
