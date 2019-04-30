extends Camera

var followDistance

export(Vector3) var shakeOffset = Vector3(0.0, 0.0, 0.0)

var target = null

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if target != null:
		updatePosition()

func setTarget(target):
	self.target = target
	
	if target != null:
		followDistance = get_global_transform().origin - target.get_global_transform().origin
		updatePosition()

func updatePosition():
	var targetPosition = target.get_global_transform().origin
	var position = get_global_transform().origin
	
	var newPosition = targetPosition
	newPosition += followDistance
	
	# Keep height the same.
	newPosition.y = position.y
	
	newPosition += shakeOffset
	
	transform.origin = newPosition # NOTE: May be wrong coordinate space.
