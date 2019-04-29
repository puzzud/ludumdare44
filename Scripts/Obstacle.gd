extends StaticBody

const playerClass = preload("res://Scripts/Player.gd")

export (float) var damage = 0.0

func _ready():
	pass

func onAreaBodyEntered(body):
	if damage <= 0.0:
		return
	
	if body is playerClass:
		body.takeDamage(damage, self)
		
		# Assume eating a carrot.
		var rustleAudioPlayers = $AudioPlayers/Rustles.get_children()
		var rustleAudioPlayer = rustleAudioPlayers[randi() % rustleAudioPlayers.size()]
		rustleAudioPlayer.play()
