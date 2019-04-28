extends CanvasLayer

func _ready():
	Global.ui = self

func updateHealthBar(healthAmount):
	var initialHealthValue = $"Top Panel/ProgressBar".value
	
	var tween = $"Top Panel/ProgressBarValueTween"
	tween.interpolate_property($"Top Panel/ProgressBar", "value", initialHealthValue, healthAmount, 0.33, Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()
	
	if initialHealthValue > healthAmount:
		$"Top Panel/ColorAnimator".play("decrement")

func onPlayerDeath():
	$"Main Caption/Dead".visible = true