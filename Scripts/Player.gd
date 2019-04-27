extends KinematicBody

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	
	$"Rabbit Import/AnimationPlayer".get_animation("default").loop = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	move_and_slide(Vector3(0,0,-5.0));

func takeDamage(damageAmount):
	health -= damageAmount
	
	Global.game.updateHealthBar()
