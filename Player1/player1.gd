extends CharacterBody2D


signal laser_shot(laser_scene, location)

const SPEED = 300.0
const ACCELERATION = 5

var laser_scene = preload("res://Laser/laser.tscn")

@onready var muzzle = $muzzle
var direction

var is_shooting = false
var fire_rate = 0.25
func _physics_process(delta):
	# Add the gravity.
	direction =  Vector2(Input.get_axis("player1_left", "player1_right"), Input.get_axis("player1_up", "player1_down"))
	
	if (direction != Vector2.ZERO):
		velocity = SPEED * direction
	else:
		velocity = Vector2.ZERO
		
	if Input.is_action_pressed("player1_shoot"):
		if not is_shooting:
			is_shooting = true
			shoot()
			await get_tree().create_timer(fire_rate).timeout
			is_shooting = false
		
		

	move_and_slide()


func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position)
