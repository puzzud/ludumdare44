extends Node

var raceFinished = false
var raceStarted = false

func _ready():
	Global.game = self
	
	$Camera.setTarget(Global.player)
	
	raceFinished = false
	raceStarted = false
	
	$Timers/StartTimer.start()
	Global.ui.startFadeIn()

func updateHealthBar(externalSource):
	Global.ui.updateHealthBar(Global.player.health, externalSource)

func onStartTimerTimeout():
	$"AudioPlayers/Start Beeps 123".play()

func onStartBeeps123Finished():
	raceStarted = true
	Global.player.running = true
	
	$"AudioPlayers/Start Beeps 4".play()
	$"AudioPlayers/Gunshot1".play()

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
	
	$AudioPlayers/Applause1.play()
	$AudioPlayers/Success1.play()

func onFinishLineTimerTimeout():
	Global.ui.startFadeOut()

func onUiFadeOutFinished():
	get_tree().reload_current_scene()
