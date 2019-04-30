extends CanvasLayer

func _ready():
	Global.ui = self

func updateHealthBar(healthAmount, externalSource):
	var initialHealthValue = $"Top Panel/ProgressBar".value
	
	var tween = $"Top Panel/ProgressBarValueTween"
	tween.interpolate_property($"Top Panel/ProgressBar", "value", initialHealthValue, healthAmount, 0.33, Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()
	
	if initialHealthValue > healthAmount:
		if externalSource:
			$"Top Panel/ColorAnimator".play("decrement_external")
		else:
			$"Top Panel/ColorAnimator".play("decrement_internal")
	elif initialHealthValue < healthAmount:
		$"Top Panel/ColorAnimator".play("increment")

func onPlayerDeath():
	$"Main Caption/Dead".visible = true

func onLeftButtonDown():
	Input.action_press("ui_left")

func onRightButtonDown():
	Input.action_press("ui_right")

func onLeftButtonUp():
	Input.action_release("ui_left")

func onRightButtonUp():
	Input.action_release("ui_right")

func onJumpButtonDown():
	Input.action_press("jump")

func onJumpButtonUp():
	Input.action_release("jump")
