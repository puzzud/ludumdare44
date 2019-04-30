extends KinematicBody

var health = 100
var running = false
export(float) var run_speed = 6.0
export(float) var jump_speed = 25.0
var gravity = 30
var velocity = Vector3()
var turning = 0
var turn_speed = run_speed
var turn_angle = 30.0
var intendedTurnAngle = 0.0
var jumped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	
	running = false
	
	var animationPlayer = $"Rabbit Import/AnimationPlayer"
	animationPlayer.stop()
	
	var defaultAnimation = animationPlayer.get_animation("default")
	defaultAnimation.loop = true
	
	animationPlayer.seek(0.0, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	getInput()
	
	if is_on_floor() && running:
		$"Rabbit Import/AnimationPlayer".play("default")

func getInput():
	if Global.game.raceFinished || !Global.game.raceStarted:
		return
	
	if !is_on_floor():
		return
		
	var jump = Input.is_action_just_pressed("jump")
	
	if jump:
		jumped = true
		
		takeDamage(15.0, self)
		
		var animationPlayer = $"Rabbit Import/AnimationPlayer"
		animationPlayer.seek(0.2, true)
		animationPlayer.stop(false)
		
		$AudioPlayers/Jumps/Jump1.play()
		
	else:
		var previousTurning = turning
		
		turning = 0
		
		var left = Input.is_action_pressed("ui_left")
		var right = Input.is_action_pressed("ui_right")
		
		if left:
			turning += -1
		
		if right:
			turning += 1
		
		if previousTurning != turning:
			var rotationDegrees = get_rotation_degrees()
			intendedTurnAngle = -turning * turn_angle
			rotationDegrees.y = intendedTurnAngle
			
			$TurnTween.stop_all()
			$TurnTween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotationDegrees, 0.125, Tween.TRANS_CIRC, Tween.EASE_OUT)
			$TurnTween.start()

func _physics_process(delta):
	if !running:
		velocity = Vector3(0.0, 0.0, 0.0)
	
	velocity.x = 0.0
	
	velocity.y -= gravity * delta
	
	if running:
		velocity.z = -run_speed
		velocity.x = turning * turn_speed
		
		if jumped:
			velocity.y += jump_speed
			jumped = false
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))

func takeDamage(damageAmount, source):
	if health <= 0.0:
		return
	
	health -= damageAmount
	if health <= 0.0:
		health = 0.0
		startDying()
	
	var externalSource = source != self
	
	Global.game.updateHealthBar(externalSource)
	
	if externalSource:
		$ColorAnimator.play("hurt")

func receiveHealth(healthAmount):
	if health <= 0.0:
		return
	
	health += healthAmount
	
	Global.game.updateHealthBar(true)
	
	# Assume eating a carrot.
	var biteAudioPlayers = $AudioPlayers/Bites.get_children()
	var biteAudioPlayer = biteAudioPlayers[randi() % biteAudioPlayers.size()]
	biteAudioPlayer.play()

func startDying():
	running = false
	
	$SizeAnimator.play("dying")
	
	Global.game.onPlayerDeath()
