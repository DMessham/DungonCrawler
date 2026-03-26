extends Node2D

var coordX = 0
var coordY = 0
var direction = 0


func get_tilemap():
	return find_child("MapCreator")
	
func _process(delta: float) -> void:
	#rotation_degrees = direction
	transform.origin.x = coordX
	transform.origin.y = coordY
func _on_player_pos_change(x: float, y: float, d: float, health: float, mana: float, inv) -> void:
	coordX = -x*8
	coordY = -y*8
	direction = d
	
	
	pass # Replace with function body.
