extends Node

func _ready():
	Global.game = self
	
	$Camera.setTarget(Global.player)

func updateHealthBar(externalSource):
	Global.ui.updateHealthBar(Global.player.health, externalSource)

func onPlayerDeath():
	Global.ui.onPlayerDeath()
	
	$Timers/PlayerDeathTimer.start()

func onPlayerDeathTimerTimeout():
	get_tree().reload_current_scene()

func onFinishLineFinishLineReached():
	get_tree().reload_current_scene()
