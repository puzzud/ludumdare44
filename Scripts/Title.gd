extends Node2D

var movingOut = true

func _ready():
	randomize()
	
	startMovement()

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		startGame()

func startMovement():
	var startPosition = Vector2(0, 0)
	var targetPosition = Vector2(0, 0)
	
	if movingOut:
		startPosition = $Rabbit2.rect_position
		
		targetPosition.x = $Rabbit2.rect_position.x + (rand_range(-1.0, 1.0) * 50.0)
		targetPosition.y = $Rabbit2.rect_position.y + (rand_range(-1.0, 1.0) * 50.0)
		#print(targetPosition)
	else:
		startPosition = $Rabbit1.rect_position
		targetPosition = $Rabbit2.rect_position
	
	$Tween.interpolate_property($Rabbit1, "rect_position", startPosition, targetPosition, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func onTweenTweenAllCompleted():
	movingOut = !movingOut
	
	startMovement()

func onStartButtonPressed():
	startGame()

func startGame():
	get_tree().change_scene("res://Scenes/Game.tscn")
