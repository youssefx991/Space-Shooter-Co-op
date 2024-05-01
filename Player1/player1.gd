class_name player1 extends CharacterBody2D

signal player_dead(number)
signal laser_shot(laser_scene, location, number)
@export var player_number = 1
@export var SPEED = 300.0
@export var ACCELERATION = 5
@export var health = 100
var laser_scene = preload("res://Laser/laser.tscn")

@onready var muzzle = $muzzle
@onready var health_label = $health_label
var direction

var is_shooting = false
@export var fire_rate = 0.25

func _ready():
	health_label.text = str(100)
	
func _physics_process(delta):
	# Add the gravity.
	if player_number == 1:
		direction =  Vector2(Input.get_axis("player1_left", "player1_right"), Input.get_axis("player1_up", "player1_down"))
	else:
		direction =  Vector2(Input.get_axis("player2_left", "player2_right"), Input.get_axis("player2_up", "player2_down"))
	
	if (direction != Vector2.ZERO):
		velocity = SPEED * direction
	else:
		velocity = Vector2.ZERO
		
	
	if Input.is_action_pressed("player1_shoot") and player_number == 1:
		if not is_shooting:
			is_shooting = true
			shoot()
			await get_tree().create_timer(fire_rate).timeout
			is_shooting = false
			
	if Input.is_action_pressed("player2_shoot") and player_number == 2:
		
		if not is_shooting:
			#print("shooting 2")
			is_shooting = true
			shoot()
			await get_tree().create_timer(fire_rate).timeout
			is_shooting = false
		
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)

	move_and_slide()


func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position, player_number)
	
	
func damage():
	health -= 10
	if health <= 0:
		die()
	else:
		health_label.text = str(health)
		
func die():
	queue_free()
	player_dead.emit(player_number)
