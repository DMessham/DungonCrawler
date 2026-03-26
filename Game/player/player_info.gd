extends Label

var coordX = 0
var coordY = 0
var fps = 0
var direction = 0
var hp = 0
var mp = 0
var stringTemp = "DMessham's Dungeon\nx: %s\ny: %s\ndir: %s\nfps: %s\nhealth: %s\nmana: %s"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fps=delta*3600
	text = stringTemp % [coordX, coordY, direction, fps, hp, mp]
	pass

func _on_player_pos_change(x: float, y: float, d: float, health: float, mana: float, inv) -> void:
	coordX = x
	coordY = y
	direction = d
	hp = health
	mp = mana
	pass # Replace with function body.
