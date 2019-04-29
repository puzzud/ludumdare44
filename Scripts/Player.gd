extends KinematicBody

signal generate_map(z_pos)
signal finish_line_reached()

var health = 100
var running = true
export(float) var run_speed = 6.0
export(float) var jump_speed = 25.0
var gravity = 30
var velocity = Vector3()
var middle_lane = 1
var lane = 1
var num_lanes = 3
var lane_x_dist = 3
var turning = 0
var turn_speed = run_speed
var turn_angle = 30.0
var grid_row = 0
var finish_line = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	
	$"Rabbit Import/AnimationPlayer".get_animation("default").loop = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	getInput()
	
	if is_on_floor():
		$"Rabbit Import/AnimationPlayer".play("default")
	
	var position = get_global_transform().origin
	var new_grid_row = int(-position.z / 3)
	if grid_row != new_grid_row:
		grid_row = new_grid_row
		emit_signal("generate_map", grid_row)
		if grid_row == finish_line:
			emit_signal("finish_line_reached")

func getInput():
	if !is_on_floor():
		return
		
	var jump = Input.is_action_just_pressed("jump")
	
	if jump:
		velocity.y += jump_speed
		var animationPlayer = $"Rabbit Import/AnimationPlayer"
		animationPlayer.seek(0.2, true)
		animationPlayer.stop(false)
		
		$AudioPlayers/Jumps/Jump1.play()
		
	else:
		turning = 0
		
		var left = Input.is_action_pressed("ui_left")
		var right = Input.is_action_pressed("ui_right")
		
		if left:
			turning += -1
		
		if right:
			turning += 1
	
	var rotationDegrees = get_rotation_degrees()
	rotationDegrees.y = -turning * turn_angle
	set_rotation_degrees(rotationDegrees)

func _physics_process(delta):
	velocity = Vector3(0.0, 0.0, 0.0)
	
	velocity.y -= gravity * delta
	
	if running:
		velocity.z = -run_speed
		velocity.x = turning * turn_speed
	
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
	
	# Assume eating a carrot.
	var biteAudioPlayers = $AudioPlayers/Bites.get_children()
	var biteAudioPlayer = biteAudioPlayers[randi() % biteAudioPlayers.size()]
	biteAudioPlayer.play()

func startDying():
	running = false
	
	$SizeAnimator.play("dying")
	
	Global.game.onPlayerDeath()

func _on_Player_finish_line_reached():
	pass # Replace with function body.
