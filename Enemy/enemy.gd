class_name enemy extends Area2D
@onready var health_label = $health_label

signal say_entered_land(location)
var SPEED = 300
var health = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	health_label.text = str(100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.y += SPEED * delta

func damage():
	health -= 10
	if health <= 0:
		die()
	else:
		health_label.text = str(health)
		
func die():
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	say_entered_land.emit(global_position)
	queue_free()
