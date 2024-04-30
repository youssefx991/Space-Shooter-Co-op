class_name laser extends Area2D
signal player_dead(player_number)
var SPEED = 1000
signal enemy_dead(number)
var player_number = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.y -= SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() 


func _on_body_entered(body):
	if body is player1:
		body.die()
		player_dead.emit(body.player_number)


func _on_area_entered(area):
	if area is enemy:
		area.damage()
		queue_free()
		if area.is_dead:
			enemy_dead.emit(player_number)
