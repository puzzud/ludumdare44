extends Spatial

func _ready():
	pass

func onAreaBodyEntered(body):
	Global.player.receiveHealth(10.0)
	
	self.queue_free()
