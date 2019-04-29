extends Spatial

const playerClass = preload("res://Scripts/Player.gd")

signal finish_line_reached

func _ready():
	pass

func onAreaBodyEntered(body):
	if body is playerClass:
		print("FINISHED")
		emit_signal("finish_line_reached")
