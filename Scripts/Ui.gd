extends CanvasLayer

func _ready():
	Global.ui = self

func updateHealthBar(healthAmount):
	$"Top Panel/ProgressBar".value = healthAmount

func onPlayerDeath():
	$"Main Caption/Dead".visible = true