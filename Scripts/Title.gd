extends Node2D

var movingOut = true

func _ready():
	randomize()
	
	moveInRabbits()
	startMovement()

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		startScreenChange()

func moveInRabbits():
	var startPosition = Vector2(1080, 0)
	var targetPosition = Vector2(0, 0)
	$Rabbits/RabbitsEntryTween.interpolate_property($Rabbits, "rect_position", startPosition, targetPosition, 0.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$Rabbits/RabbitsEntryTween.start()
	
	$AudioPlayers/Whoosh1.play()

func startMovement():
	var startPosition = Vector2(0, 0)
	var targetPosition = Vector2(0, 0)
	
	if movingOut:
		startPosition = $Rabbits/Rabbit2.rect_position
		
		targetPosition.x = $Rabbits/Rabbit2.rect_position.x + (rand_range(-1.0, 1.0) * 50.0)
		targetPosition.y = $Rabbits/Rabbit2.rect_position.y + (rand_range(-1.0, 1.0) * 50.0)
		#print(targetPosition)
	else:
		startPosition = $Rabbits/Rabbit1.rect_position
		targetPosition = $Rabbits/Rabbit2.rect_position
	
	$Rabbits/Rabbit2Tween.interpolate_property($Rabbits/Rabbit1, "rect_position", startPosition, targetPosition, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Rabbits/Rabbit2Tween.start()

func onTweenTweenAllCompleted():
	movingOut = !movingOut
	
	startMovement()

func onStartButtonPressed():
	startScreenChange()

func startGame():
	get_tree().change_scene("res://Scenes/Game.tscn")

func startScreenChange():
	var screenFader = $CanvasLayer2/ScreenFader
	screenFader.visible = true
	screenFader.get_node("AnimationPlayer").play("fadeOut")
	
	$AudioPlayers/Whoosh1.play()

func onScreenFaderFadeOutFinished():
	startGame()
