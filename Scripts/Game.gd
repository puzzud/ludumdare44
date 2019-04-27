extends Node

func _ready():
	Global.game = self

func updateHealthBar():
	Global.ui.updateHealthBar(Global.player.health)
