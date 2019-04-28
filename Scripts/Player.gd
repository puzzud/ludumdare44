extends KinematicBody

var health = 100
var run_speed = 6
var jump_speed = 25
var gravity = 30
var velocity = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	
	$"Rabbit Import/AnimationPlayer".get_animation("default").loop = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_on_floor():
		$"Rabbit Import/AnimationPlayer".play("default")

func getInput():
	var jump = Input.is_action_just_pressed("jump")
	if jump and is_on_floor():
		velocity.y += jump_speed
		$"Rabbit Import/AnimationPlayer".stop(false)
		
func _physics_process(delta):
	velocity.y -= gravity * delta
	velocity.z = -run_speed
	getInput()
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
