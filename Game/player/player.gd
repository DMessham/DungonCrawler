extends CharacterBody3D

@export var direction := Vector3.FORWARD
@export var rotation_time := 0.2

@onready var forward: = $Ray_front
@onready var camera = $Camera3D

var health = 100
var mana = 100
var inventory = []

var frameTime = 0.03

var newX = global_transform.origin.x
var newZ = global_transform.origin.z

signal posChange

var is_rotating := false

const SPEED = 100

const moveSpeed = 0.001

func collision_check(directionw):
	if directionw != null:
		return directionw.is_colliding()
	else:
		return false

func move():

	rotation_degrees.y = round(rotation_degrees.y) 
	if !forward.is_colliding():
		newX = round(global_transform.origin.x) + direction.x
		newZ = round(global_transform.origin.z) + direction.z

	global_transform.origin.x = round(newX)
	global_transform.origin.z = round(newZ)
func _input(event):
	if is_rotating:
		return
	if event.is_action_pressed("ui_up"):
		move()
	if event.is_action_pressed("ui_left"):
		rotate_and_set_direction(90)
	if event.is_action_pressed("ui_right"):
		rotate_and_set_direction(-90)
	if event.is_action_pressed("ui_down"):
		rotate_and_set_direction(180)
	
func _process(delta: float) -> void:
	posChange.emit(global_transform.origin.x,global_transform.origin.z,rotation_degrees.y, health, mana, inventory)
	frameTime = 0.00003333333/(delta)
	
	#if(global_transform.origin.x < newX -moveSpeed/frameTime) && !(forward.is_colliding()):
		#global_transform.origin.x+=moveSpeed/frameTime
	#elif(global_transform.origin.x > newX+moveSpeed/frameTime) && !(forward.is_colliding()):
		#global_transform.origin.x-=moveSpeed/frameTime
	#else:
		#global_transform.origin.x = round(global_transform.origin.x)
	#if(global_transform.origin.z < newZ-moveSpeed/frameTime) && (!forward.is_colliding()):
		#global_transform.origin.z+=moveSpeed/frameTime
	#elif(global_transform.origin.z > newZ+moveSpeed/frameTime) && (!forward.is_colliding()):
		#global_transform.origin.z-=moveSpeed/frameTime
	#else:
		#global_transform.origin.z = round(global_transform.origin.z)
		


func rotate_and_set_direction(angle_delta: float):
	is_rotating = true
	var new_y = rotation_degrees.y + angle_delta
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees:y", new_y, rotation_time).set_ease(Tween.EASE_OUT)
	await tween.finished
	direction = -global_transform.basis.z.normalized()
	rotation_degrees.y = round(new_y) 
	is_rotating = false
	
	
	
