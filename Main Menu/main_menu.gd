extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_multi_pressed():
	get_tree().change_scene_to_file("res://World/world.tscn")
	


func _on_quit_pressed():
	get_tree().quit()


func _on_single_pressed():
	get_tree().change_scene_to_file("res://single player world/single_player_world.tscn")
