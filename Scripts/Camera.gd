extends Camera

export(Vector3) var followDistance

var target = null

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if target != null:
		updatePosition()

func setTarget(target):
	self.target = target
	
	if target != null:
		updatePosition()

func updatePosition():
	var targetPosition = target.get_global_transform().origin
	var position = get_global_transform().origin
	
	var newPosition = targetPosition
	newPosition += followDistance
	
	# Keep height the same.
	newPosition.y = position.y
	
	transform.origin = newPosition # NOTE: May be wrong coordinate space.
	
	#global_translate(newPosition)
	
	# Keep camera looking straight down.
	#var lookAtPosition = targetPosition
	#lookAtPosition.y = position.y
	
	#print(str(newPosition) + ":" + str(lookAtPosition))
	
	#look_at_from_position(newPosition, lookAtPosition, Global.UpDirection)
