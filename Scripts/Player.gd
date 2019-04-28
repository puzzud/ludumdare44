extends KinematicBody

var health = 100
var run_speed = 6
var jump_speed = 25
var gravity = 30
var velocity = Vector3()
var middle_lane = 1
var lane = 1
var num_lanes = 3
var lane_x_dist = 3
var turning = 0
var turn_speed = run_speed
var turn_angle = .15

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	
	$"Rabbit Import/AnimationPlayer".get_animation("default").loop = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_on_floor():
		$"Rabbit Import/AnimationPlayer".play("default")

func getInput():
	if !is_on_floor() or turning != 0:
		return
		
	var jump = Input.is_action_just_pressed("jump")
	var left = Input.is_action_just_pressed("ui_left")
	var right = Input.is_action_just_pressed("ui_right")
	
	if jump:
		velocity.y += jump_speed
		var animationPlayer = $"Rabbit Import/AnimationPlayer"
		animationPlayer.seek(0.2, true)
		animationPlayer.stop(false)
	elif left and lane > 0:
		turning = -1
		rotate_y(-turning * turn_angle)
	elif right and lane < num_lanes-1:
		turning = 1
		rotate_y(-turning * turn_angle)

func handleTurning():
	var position = get_global_transform().origin
	if turning == -1: # Turning left
		if position.x <= ((lane-middle_lane-1) * lane_x_dist):
			rotate_y(turning * turn_angle)
			turning = 0
			lane -= 1
	elif turning == 1: # Turning right
		if position.x >= ((lane-middle_lane+1) * lane_x_dist):
			rotate_y(turning * turn_angle)
			turning = 0
			lane += 1
	velocity.x = turning * turn_speed
		
func _physics_process(delta):
	velocity.y -= gravity * delta
	velocity.z = -run_speed
	getInput()
	if turning:
		handleTurning()
	velocity = move_and_slide(velocity, Vector3(0,1,0))

func takeDamage(damageAmount):
	if health <= 0.0:
		return
	
	health -= damageAmount
	if health <= 0.0:
		health = 0.0
		startDying()
	
	Global.game.updateHealthBar()
	
	$ColorAnimator.play("hurt")

func receiveHealth(healthAmount):
	if health <= 0.0:
		return
	
	health += healthAmount
	
	Global.game.updateHealthBar()

func startDying():
	$SizeAnimator.play("dying")
	
	Global.game.onPlayerDeath()
