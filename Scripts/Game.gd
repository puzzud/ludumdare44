extends Node

var raceFinished = false

func _ready():
	Global.game = self
	
	$Camera.setTarget(Global.player)
	
	raceFinished = false
	
	$Timers/StartTimer.start()

func updateHealthBar(externalSource):
	Global.ui.updateHealthBar(Global.player.health, externalSource)

func onStartTimerTimeout():
	Global.player.running = true

func onPlayerDeath():
	Global.ui.onPlayerDeath()
	
	$Timers/PlayerDeathTimer.start()
	
	$AudioPlayers/Whistle1.play()

func onPlayerDeathTimerTimeout():
	get_tree().reload_current_scene()

func onFinishLineFinishLineReached():
	raceFinished = true
	
	$Camera.setTarget(null)
	
	$Timers/FinishLineTimer.start()

func onFinishLineTimerTimeout():
	get_tree().reload_current_scene()
