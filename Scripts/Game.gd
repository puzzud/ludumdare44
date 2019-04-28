extends Node

func _ready():
	Global.game = self
	
	$Camera.setTarget(Global.player)

func updateHealthBar():
	Global.ui.updateHealthBar(Global.player.health)

func onPlayerDeath():
	Global.ui.onPlayerDeath()
	
	$Timers/PlayerDeathTimer.start()

func onPlayerDeathTimerTimeout():
	get_tree().reload_current_scene()
