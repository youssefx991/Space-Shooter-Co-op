class_name player1 extends CharacterBody2D


signal laser_shot(laser_scene, location)

const SPEED = 300.0
const ACCELERATION = 5
var health = 100
var laser_scene = preload("res://Laser/laser.tscn")

@onready var muzzle = $muzzle
@onready var health_label = $health_label
var direction

var is_shooting = false
var fire_rate = 0.25

func _ready():
	health_label.text = str(100)
	
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
	
	
func damage():
	health -= 10
	if health <= 0:
		die()
	else:
		health_label.text = str(health)
		
func die():
	queue_free()
