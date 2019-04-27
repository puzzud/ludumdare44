extends StaticBody

const playerClass = preload("res://Scripts/Player.gd")

export (float) var damage = 0.0

func _ready():
	pass

func onAreaBodyEntered(body):
	if damage <= 0.0:
		return
	
	if body is playerClass:
		body.takeDamage(damage)
