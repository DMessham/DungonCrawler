extends CharacterBody3D

@export var direction := Vector3.FORWARD
@export var rotation_time := 0.2

@onready var forward: = $Ray_front
@onready var camera = $Camera3D

var health = 100
var mana = 100
var inventory = []


signal posChange

var is_rotating := false

const SPEED = 100

func collision_check(direction):
	if direction != null:
		return direction.is_colliding()
	else:
		return false

func move():
	if !forward.is_colliding():
		global_transform.origin.x += direction.x
		global_transform.origin.z += direction.z

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


func rotate_and_set_direction(angle_delta: float):
	is_rotating = true
	var new_y = rotation_degrees.y + angle_delta
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees:y", new_y, rotation_time).set_ease(Tween.EASE_OUT)
	await tween.finished
	direction = -global_transform.basis.z.normalized()
	is_rotating = false
	
	
	
